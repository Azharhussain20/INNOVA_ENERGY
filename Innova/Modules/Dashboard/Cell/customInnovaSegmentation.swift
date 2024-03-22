//
//  customInnovaSegmentation.swift
//  Innova
//
//  Created by Azhar - M1 on 21/03/24.
//


import UIKit
protocol segmentSelectionIndexDelegate: AnyObject {
    func didselectedSegmentIndex(index: Int)
}

@IBDesignable
class customInnovaSegmentation: UIView {
    @IBOutlet weak var btnCalendar: UIButton!
    @IBOutlet weak var btnPreset: UIButton!
    @IBOutlet weak var mainView: UIView!
    public weak var delegate: segmentSelectionIndexDelegate?

    @objc public var isCalenderSelected = false {
        didSet {
            self.btnCalendar.backgroundColor = isCalenderSelected ? appConfig.appColors.themeColor : appConfig.appColors.grayFive
            self.btnPreset.backgroundColor = isCalenderSelected ? appConfig.appColors.grayFive : appConfig.appColors.themeColor
            self.btnCalendar.setTitleColor(isCalenderSelected ? UIColor.white : appConfig.appColors.btnInActiveTextColor, for: .normal)
            self.btnPreset.setTitleColor(isCalenderSelected ? appConfig.appColors.btnInActiveTextColor : UIColor.white, for: .normal)
            self.btnCalendar.layer.cornerRadius = isCalenderSelected ? 16 : 0
            self.btnPreset.layer.cornerRadius = isCalenderSelected ? 0 : 16
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
    private func setup() {
        mainView = fromNib()
        mainView.frame = bounds
        frame = mainView.frame
        mainView.layer.cornerRadius = 16.0
        addSubview(mainView)  
        isCalenderSelected = true
        btnPreset.addTarget(self, action: #selector(btnPresetTapped(_:)), for: .touchUpInside)
        btnCalendar.addTarget(self, action: #selector(btnCalenderTapped(_:)), for: .touchUpInside)
    }
    

    @objc func btnPresetTapped(_ sender: UIButton) {
        isCalenderSelected = false
        delegate?.didselectedSegmentIndex(index: 1)
        
    }
    @objc func btnCalenderTapped(_ sender: UIButton) {
        isCalenderSelected = true
        delegate?.didselectedSegmentIndex(index: 0)
    }
     
    
}
