//
//  FanModeSelector.swift
//  Innova
//
//  Created by Massimiliano Montagni on 19/12/22.
//
import UIKit

protocol FanModeSelectorDelegate: AnyObject {
    func fanModeDidSelect(mode: Device.FanMode)
}

@IBDesignable
class FanModeSelector: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {
    
    
    @IBOutlet private var mainView: UIView!
    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet private weak var pickerViewHeightConstraint: NSLayoutConstraint!
    
    
    private typealias CurrentFanMode = (text: String, mode: Device.FanMode)
    private var isPickerHidden = true
    private var autoCloseTimer: Timer?
    private var pickerViewHeight: CGFloat!
    private var pickerViewRowHeight: CGFloat!
    private var modeTitles = [CurrentFanMode(text: "Auto", mode: .auto),
                              CurrentFanMode(text: "Min", mode: .min),
                              CurrentFanMode(text: "Mid", mode: .mid),
                              CurrentFanMode(text: "Max", mode: .max)]
    
    
    public weak var delegate: FanModeSelectorDelegate?
    public var selectedMode: Device.FanMode = .auto {
        didSet {
            let modeTitleIdx = modeTitles.firstIndex { $0.mode == selectedMode }
            guard let modeTitleIdx = modeTitleIdx else { return }
            
            pickerView.selectRow(modeTitleIdx, inComponent: 0, animated: true)
        }
    }
    
    public var isDisabled: Bool = false {
        didSet {
            isUserInteractionEnabled = !isDisabled
            setAlpha(isDisabled ? 0.5 : 1.0)
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainView.frame = bounds
    }
    
    private func setup() {
        mainView = fromNib()
        mainView.frame = bounds
        frame = mainView.frame
        mainView.layer.cornerRadius = 16.0
        addSubview(mainView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleButtonTap))
        tapGesture.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.addGestureRecognizer(tapGesture)
        
        mainView.addGestureRecognizer(tapGesture)
        pickerViewHeight = pickerViewHeightConstraint.constant
        pickerViewRowHeight = pickerView.rowSize(forComponent: 0).height * 2.0
        pickerViewHeightConstraint.constant = pickerViewRowHeight
    }
    
    @objc private func handleButtonTap() {
        autoCloseTimer?.invalidate()
        autoCloseTimer = nil
        isPickerHidden.toggle()
        pickerView.isUserInteractionEnabled = !isPickerHidden
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.pickerViewHeightConstraint.constant = self.isPickerHidden ? self.pickerViewRowHeight : self.pickerViewHeight
            self.mainView.backgroundColor = self.isPickerHidden ? appConfig.appColors.grayFive : appConfig.appColors.themeColor
        } completion: { [weak self] _ in
            guard let self = self else { return }
            
            if !self.isPickerHidden {
                self.createAutoCloseTimer()
            }
        }
    }
    
    public func close() {
        if isPickerHidden {
            return
        }
        handleButtonTap()
    }
    
    private func createAutoCloseTimer() {
        if autoCloseTimer != nil {
            autoCloseTimer?.invalidate()
            autoCloseTimer = nil
        }
        
        autoCloseTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { [weak self] _ in
            guard let self = self else { return }
            self.handleButtonTap()
            self.autoCloseTimer = nil
        })
    }
    
    internal func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.fanModeDidSelect(mode: modeTitles[row].mode)
        createAutoCloseTimer()
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nil
    }
    
    internal func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        autoCloseTimer?.invalidate()
        autoCloseTimer = nil
        
        for subview in pickerView.subviews {
            subview.backgroundColor = .clear
        }
        
        let size = pickerView.rowSize(forComponent: component)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let title = modeTitles[row].text
        
        label.text = title
        label.textColor = appConfig.appColors.themeColor
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        
        return label
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modeTitles.count
    }
    
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    private func setAlpha(_ alpha: CGFloat) {
        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let self = self else { return }
            
            self.mainView.alpha = alpha
        }
    }
}

extension UIView {
    func fromNib<T: UIView>(nibName name: String = "") -> T {
        let bundleName = Bundle(for: type(of: self))
        var nibName = name
        if nibName == "" {
            nibName = String(describing: type(of: self))
        }
        let nib = UINib(nibName: nibName, bundle: bundleName)
        let views = nib.instantiate(withOwner: self, options: nil)
        return views.first as! T
    }
}
