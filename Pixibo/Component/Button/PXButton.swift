//
//  PXButton.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/27/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setUpPrimaryButton() {
        setTitleColor(UIColor.white, for: UIControl.State.normal)
        backgroundColor =  UIColor.pureBlue
    }
    
    func setUpSecondaryButton() {
        setTitleColor(UIColor.black, for: UIControl.State.normal)
        backgroundColor =  UIColor.clear
    }
    
    func addBorder() {
        self.layer.borderColor = UIColor.brownGrey.cgColor
        self.layer.borderWidth = 1.0
    }
    
    func disableUI() {
        self.alpha = 0.5
        self.isUserInteractionEnabled = false
    }
    
    func enableUI() {
        self.alpha = 1
        self.isUserInteractionEnabled = true
    }
}
