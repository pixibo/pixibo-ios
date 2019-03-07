//
//  PXTextField.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/27/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXTextField: UITextField {
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }
    
    @IBInspectable var rightPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
           // updateView()
        }
    }
    
    @IBInspectable var rightImage : UIImage?{
        didSet{
            updateView()
        }
    }
    
    func updateView() {
        if let image = rightImage {
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            rightView = imageView
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont.dropdownUnselected])
        font = UIFont.dropdownSelected
    }
    
   
}
//
//// Provides left padding for images
//override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
//    var textRect = super.leftViewRect(forBounds: bounds)
//    textRect.origin.x += leftPadding
//    return textRect
//}
//
//@IBInspectable var leftImage: UIImage? {
//    didSet {
//        updateView()
//    }
//}
//
//@IBInspectable var leftPadding: CGFloat = 0
//
//@IBInspectable var color: UIColor = UIColor.lightGray {
//    didSet {
//        updateView()
//    }
//}
//
//func updateView() {
//    if let image = leftImage {
//        leftViewMode = UITextFieldViewMode.always
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = image
//        // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
//        imageView.tintColor = color
//        leftView = imageView
//    } else {
//        leftViewMode = UITextFieldViewMode.never
//        leftView = nil
//    }
//
//    // Placeholder text color
//    attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: color])
//}
//}
