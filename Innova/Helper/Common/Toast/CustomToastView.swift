//
//  CustomToastView.swift
//  Innova
//
//  Created by Azhar - M1 on 08/03/24.
//

import UIKit

class CustomToastView: UIView {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnClose: UIButton!
    
    //------------------------------------------
    //MARK: - Class Variables -
    let toastHeight: CGFloat = 56
    
    //------------------------------------------
    //MARK: - XIB Initialise -
    static func loadFromNib() -> CustomToastView {
        let nib = UINib(nibName: "CustomToastView", bundle: nil)
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! CustomToastView
        return view
    }
    
    //------------------------------------------
    //MARK: - Action Methods -
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        removeFromSuperview()
    }
    
    //------------------------------------------
    //MARK: - Custom Methods -
    
    func toastConfigure(_ message: String? = nil, _ buttonImage: UIImage? = nil, _ isButtonVisible: Bool? = nil, _ forgroundColor: UIColor? = nil, _ backgroundColor: UIColor? = nil, _ dismissOnTap: Bool? = nil) {
        messageLabel.text = message
        containerView.backgroundColor = (backgroundColor != nil) ? backgroundColor : appConfig.appColors.grayFour
        messageLabel.textColor = (forgroundColor != nil) ? forgroundColor : appConfig.appColors.titleBlack
        guard let isButtonVisible = isButtonVisible else {
            return
        }
        btnClose.isHidden = !isButtonVisible
    }
    
    
    func showToast(_ toastView: CustomToastView) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
            containerView.layer.shadowOpacity = 0.4
            containerView.layer.shadowRadius = 8
            let window = windowScene.windows.first { $0.isKeyWindow }
            let bottomPadding = window!.safeAreaInsets.bottom
            let toastY = (window?.frame.height)! - CGFloat(bottomPadding + toastHeight)
            toastView.frame = CGRect(x: 0, y: toastY, width: UIScreen.main.bounds.width, height: toastHeight)
            window?.addSubview(toastView)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                toastView.frame.origin.y -= self.toastHeight
            }) { _ in
                self.hideToast()
            }
        }
    }
    
    func hideToast(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.frame.origin.y += self.toastHeight
            }) { _ in
                self.removeFromSuperview()
            }
        }
    }
}
