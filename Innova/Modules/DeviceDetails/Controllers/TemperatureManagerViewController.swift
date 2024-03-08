//
//  TemperatureManagerViewController.swift
//  Innova
//
//  Created by Azhar - M1 on 06/03/24.
//

import UIKit

protocol TrueTemperatureViewControllerDelegate: AnyObject {
    func temperature(temp: Float)
}

class TemperatureManagerViewController: UIViewController {
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet private weak var minusBtn: UIButton!
    @IBOutlet private weak var plusBtn: UIButton!
    @IBOutlet private weak var temperatureLbl: UILabel!
    
    
    //------------------------------------------
    //MARK: - Class Variables -
    private let step: Float = 0.1
    private var minVal: Float = -30.0
    private var maxVal: Float = 30.0
    private var timer: Timer?
    private var temperature: Float = 22.0 {
        didSet {
            temperatureLbl.text = String(format: "%.1f° C", temperature)
        }
    }
    weak var delegate: TrueTemperatureViewControllerDelegate?
    
    //------------------------------------------
    //MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        didAddGestures()
    }
    
    //------------------------------------------
    //MARK: - Custom Methods -
    func didAddGestures(){
        let gestureDelay = 0.1
        
        let minusBtnLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(minusBtnLongPressure(_:)))
        minusBtnLongPressGesture.minimumPressDuration = gestureDelay
        minusBtn.addGestureRecognizer(minusBtnLongPressGesture)
        
        let plusBtnLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(plusBtnLongPressure(_:)))
        plusBtnLongPressGesture.minimumPressDuration = gestureDelay
        plusBtn.addGestureRecognizer(plusBtnLongPressGesture)
    }
    
    func startTimer(increasing: Bool) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if increasing {
                if temperature <= maxVal {
                    temperature += step
                } else {
                    stopTimer()
                }
            } else {
                if temperature > minVal {
                    temperature -= step
                } else {
                    stopTimer()
                }
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    //------------------------------------------
    //MARK: - Action Methods
    @IBAction func abortBtnClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func confirmBtnClicked(_ sender: UIButton) {
        delegate?.temperature(temp: temperature)
        dismiss(animated: true)
    }
    
    @IBAction func minusBtnClicked(_ sender: UIButton) {
        stopTimer()
        if temperature > minVal {
            temperature -= step
        }
    }
    
    @objc func minusBtnLongPressure(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            minusBtn.alpha = 0.5
            startTimer(increasing: false)
        } else if sender.state == .ended {
            minusBtn.alpha = 1.0
            stopTimer()
        }
    }
    
    @IBAction func plusBtnClicked(_ sender: UIButton) {
        stopTimer()
        if temperature <= maxVal {
            temperature += step
        }
    }
    
    @objc func plusBtnLongPressure(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            plusBtn.alpha = 0.5
            startTimer(increasing: true)
        case .ended, .cancelled, .failed:
            plusBtn.alpha = 1.0
            stopTimer()
        default:
            break
        }
    }
}
