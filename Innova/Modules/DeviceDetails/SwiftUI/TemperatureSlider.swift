//
//  TemperatureSlider.swift
//  Innova
//
//  Created by Massimiliano Montagni on 19/11/22.
//

// FIXME: if currentTemp is under the minTemp the selector glitches but the text

import SwiftUI
//import CoreHaptics

extension Double {
    
    func toNextFive() -> Double {
        let round = self / 0.5
        
        return round.rounded(.toNearestOrEven) * 0.5
    }
    
}

extension Color {
    
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
}

protocol TemperatureSliderViewModelDelegate: AnyObject {
    
    func temperatureDidUpdate(temperature: Double)
    func powerBtnClicked()
    
}

class TemperatureSliderViewModel: ObservableObject {
    
    weak var delegate: TemperatureSliderViewModelDelegate?
    
    var maxAngle: Double {
        return TemperatureSlider.maxCircle * 360.0
    }
    
    let maxTemperature: Double = 31.0
    let minTemperature: Double = 16.0
    
    @Published var size: CGSize = CGSize(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.width * 0.6)
    
    @Published var isDisabled = false
    
    @Published var angle: Double = 0.0
    @Published var currentTemperature: Double = 16.0 {
        didSet {
            let roundedTemperature = currentTemperature.toNextFive()
            
            if roundedTemperature > maxTemperature {
                currentTemperature = maxTemperature
            } else if roundedTemperature < minTemperature {
                currentTemperature = minTemperature
            }
            
            if oldValue.toNextFive() == roundedTemperature {
                return
            }
            
            delegate?.temperatureDidUpdate(temperature: roundedTemperature)
            let progress = (roundedTemperature - minTemperature) / (maxTemperature - minTemperature)
            
            if roundedTemperature.truncatingRemainder(dividingBy: 0.5) == 0 {
                //                Vibrator.vibrate(style: .soft)
            }
            
            withAnimation(Animation.linear(duration: 0.1)) { [weak self] in
                guard let self = self else { return }
                
                self.angle = progress * maxAngle
            }
        }
    }
    
    public func onChanged(value: DragGesture.Value) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        let radians = atan2(vector.dy - (TemperatureSlider.indicatorSize / 2.0), vector.dx - (TemperatureSlider.indicatorSize / 2.0))
        let tmpAngle = radians * 180.0 / .pi
        
        let angle = tmpAngle < 0 ? 360 + tmpAngle : tmpAngle
        if angle <= maxAngle {
            let progress = angle / maxAngle
            currentTemperature = progress * (maxTemperature - minTemperature) + minTemperature
        }
    }
    
}

struct TemperatureSlider: View {
    
    @ObservedObject var sliderData: TemperatureSliderViewModel
    
    static let maxCircle: CGFloat = 0.8
    static let sliderWidth: CGFloat = 20.0
    static let indicatorSize: CGFloat = Self.sliderWidth * 1.5
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    ZStack {
                        Circle()
                            .trim(from: 0, to: Self.maxCircle)
                            .stroke(Color(hue: 0.0, saturation: 0.0, brightness: 0.9),
                                    style: StrokeStyle(lineWidth: Self.sliderWidth, lineCap: .round))
                            .opacity(sliderData.isDisabled ? 0.4 : 1.0)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        
                        Circle()
                            .trim(from: 0, to: sliderData.angle / 360)
                            .stroke(AngularGradient(gradient: Gradient(colors: [Color(hex: 0x008375),
                                                                                Color(hex: 0x8EB17C),
                                                                                Color(hex: 0xE9C46A),
                                                                                Color(hex: 0xF4A261),
                                                                                Color(hex: 0xE76F51)]),
                                                    center: .center,
                                                    startAngle: .zero,
                                                    endAngle: .degrees(360 - (90 + (1.0 - Self.maxCircle) / 2.0 * 360.0))),
                                    style: StrokeStyle(lineWidth: Self.sliderWidth, lineCap: .round))
                            .opacity(sliderData.isDisabled ? 0.4 : 1.0)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        
                        Circle()
                            .fill(Color.white.opacity(1))
                            .shadow(color: Color(appConfig.appColors.grayTwo), radius: 4)
                            .frame(width: Self.indicatorSize, height: Self.indicatorSize)
                            .offset(x: sliderData.size.width / 2)
                            .rotationEffect(.init(degrees: sliderData.angle))
                            .gesture(DragGesture()
                                .onChanged(sliderData.onChanged(value:)))
                    }
                    .rotationEffect(.degrees(90 + (1.0 - Self.maxCircle) / 2.0 * 360.0))
                    .disabled(sliderData.isDisabled)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    let temperatureString = "\(String.localizedStringWithFormat("%.1f°", sliderData.currentTemperature.toNextFive()))"
                    
                    let parts = temperatureString.split(separator: ".")
                    let integerPart = String(parts[0])
                    let decimalPart = String(parts[1])
                    VStack {
                        HStack (alignment: .lastTextBaseline){
                            Text(integerPart)
                                .font(.system(size: 60, design: .rounded))
                                .foregroundColor(sliderData.isDisabled ? Color(appConfig.appColors.grayTwo) : Color(appConfig.appColors.themeColor)) // Adjust color as needed
                            
                            Text(".\(decimalPart)")
                                .font(.system(size: 30, design: .rounded))
                                .foregroundColor(sliderData.isDisabled ? Color(appConfig.appColors.grayTwo) : Color(appConfig.appColors.themeColor)) // Adjust color as needed
                        }
                        Text("Temperature") // Adjust color as needed

                    }
                   
                    
                    Button(action: {
                        sliderData.delegate?.powerBtnClicked()
                        //                        Vibrator.vibrate(style: .light)
                    }) {
                        Image(systemName: "power")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(sliderData.isDisabled ? Color(appConfig.appColors.grayTwo) : Color(appConfig.appColors.themeColor))
                            .padding()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .offset(x: 0, y: geometry.size.height / 2 - 22)
                }
            }
            .frame(width: sliderData.size.width, height: sliderData.size.height)
        }
    }
}

struct TemperatureSlider_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureSlider(sliderData: TemperatureSliderViewModel())
    }
}
