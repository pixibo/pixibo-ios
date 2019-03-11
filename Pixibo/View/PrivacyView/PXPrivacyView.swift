//
//  PXPrivacyView.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/30/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXPrivacyView: UIView {

    @IBOutlet weak var privacyButton: UIButton!
    
    let yourAttributes : [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font : UIFont.error,
        NSAttributedString.Key.foregroundColor : UIColor.pureBlue,
        NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    /// This method is initializing the ZCustomSearchView class and all the attributes are getting set here.
    private func commonInit() {
        
    }
    

    func setUpUI() {
        let attributeString = NSMutableAttributedString(string: "Privacy Policy",
                                                        attributes: yourAttributes)
        privacyButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    @IBAction func privacyButtonClicked(_ sender: Any) {
        let privacyStr = "https://wearepixibo.com/privacypolicy"
        if UIApplication.shared.canOpenURL(URL(string: privacyStr)!){
            UIApplication.shared.open(URL(string: privacyStr)!, options: [:]) { (true) in
            }
        }
    }
    
}
