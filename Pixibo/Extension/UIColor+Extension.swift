//
//  UIColor+Extension.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/27/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit
extension UIColor {
    class var veryLightPink: UIColor {
        return UIColor(white: 237.0 / 255.0, alpha: 1.0)
    }
    
    class var pureBlue: UIColor {
        return UIColor(red: 0.0, green: 0.0, blue: 229.0 / 255.0, alpha: 1.0)
    }
    
    class var coralPink: UIColor {
        return UIColor(red: 1.0, green: 94.0 / 255.0, blue: 108.0 / 255.0, alpha: 1.0)
    }
    
    class var brightYellow: UIColor {
        return UIColor(red: 237.0 / 255.0, green: 1.0, blue: 0.0, alpha: 1.0)
    }
    
    class var white: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }
    
    class var black: UIColor {
        return UIColor(white: 0.0, alpha: 1.0)
    }
    
    class var brownGrey: UIColor {
        return UIColor(white: 151.0 / 255.0, alpha: 1.0)
    }
    
    class var paleTeal: UIColor {
        return UIColor(red: 148.0 / 255.0, green: 204.0 / 255.0, blue: 156.0 / 255.0, alpha: 1.0)
    }
    class var darkBrownGrey: UIColor {
        return UIColor(red: 155.0 / 255.0, green: 155.0 / 255.0, blue: 155.0 / 255.0, alpha: 1.0)
    }

}

extension UIColor {
    
    static func backgroundColor() -> UIColor {
        return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    static func primaryColor() -> UIColor {
        return UIColor(red: 0.0 / 255.0, green: 0 / 255.0, blue: 229 / 255.0, alpha: 1.0)
    }
    
    static func secondaryColor() -> UIColor {
        return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    static func primaryTextColor() -> UIColor {
        return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    static func secondaryTextColor() -> UIColor {
        return UIColor(red: 0.0 / 255.0, green: 30 / 255.0, blue: 220 / 255.0, alpha: 1.0)
    }
}
