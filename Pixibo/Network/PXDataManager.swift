//
//  PXDataManager.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 2/19/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXDataManager: NSObject {

    static let sharedManager = PXDataManager()
    var resultModel: PXResultModel?
    var fitPrefParams: Dictionary<String,String>? = [:]
    var selectedFirPrefType = PXConstant.firPrefType.PXRegular
    var pdpPageString: NSMutableAttributedString?
    

    private override init() {
        super.init()
        setEntryPageTitle(title: "FIND MY SIZE")
    }

    func setEntryPageTitle(title: String) {
        let mutableAttributedString = NSMutableAttributedString()

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 2            // Paragraph Spacing
        paragraphStyle.lineSpacing = 1.4
        
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont.buttonSelected,
            NSAttributedString.Key.foregroundColor: UIColor.pureBlue,
            NSAttributedString.Key.kern: 0.2,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]
        
        
        let regularAttributedString = NSAttributedString(string: title, attributes: regularAttribute)
        mutableAttributedString.append(regularAttributedString)
        pdpPageString = mutableAttributedString
    }
    
    func setEntryPageTitleOnSelection(text: String) {
        let mutableAttributedString = NSMutableAttributedString()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 2            // Paragraph Spacing
        paragraphStyle.lineSpacing = 1.4
        
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont.buttonSelected,
            NSAttributedString.Key.foregroundColor: UIColor.pureBlue,
            NSAttributedString.Key.kern: 0.2,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]
        
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont.buttonNormal,
            NSAttributedString.Key.foregroundColor: UIColor.pureBlue,
            NSAttributedString.Key.kern: 0.2,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]
        
        
        let regularAttributedString = NSAttributedString(string: "YOU’LL LOOK BEST IN ", attributes: regularAttribute)
        
        let boldAttributedString = NSAttributedString(string: text.uppercased(), attributes: boldAttribute)
        mutableAttributedString.append(regularAttributedString)
        mutableAttributedString.append(boldAttributedString)
        pdpPageString = mutableAttributedString
    }
    
    func reset() {
//        resultModel = nil
        selectedFirPrefType = PXConstant.firPrefType.PXRegular
//        setEntryPageTitle(title: "FIND MY SIZE")
        fitPrefParams = [:]

    }
}
