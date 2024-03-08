//
//  ButtonWithLeftAlignedImageAndCenteredText.swift
//  Innova
//
//  Created by Azhar - M1 on 24/01/24.
//

import UIKit

class ButtonWithLeftAlignedImageAndCenteredText: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel?.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        var imageFrame = super.imageRect(forContentRect: contentRect)
        imageFrame.origin.x = 20 //offset from left edge
        return imageFrame
    }

    override func titleRect(forContentRect contentRect:CGRect) -> CGRect {
        var titleFrame = super.titleRect(forContentRect: contentRect)
        titleFrame = self.bounds
        return titleFrame
    }


  
}
