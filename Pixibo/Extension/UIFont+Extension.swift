//
//  UIColor+Extension.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/27/19.
//  Copyright © 2019 Pixibo. All rights reserved.
///

import UIKit

extension UIFont {

  class var mainSize: UIFont {
    return UIFont(name: "AkGroteskNextWeb-MedExt", size: 50.0)!
  }

    class var navigationTitle: UIFont {
        return UIFont(name: "AkGroteskNextWeb-MedExt", size: 14.0)!
    }

  class var title1FormerlyZ1Heading1: UIFont {
    return UIFont(name: "Roboto-Regular", size: 18.0)!
  }

  class var entrypageNumbers: UIFont {
    return UIFont(name: "AkGroteskNextWeb-RegularExt", size: 16.0)!
  }

  class var dropdownSelected: UIFont {
    return UIFont(name: "AkGroteskNextWeb-MedExt", size: 12.0)!
  }

  class var dropdownUnselected: UIFont {
    return UIFont(name: "AkGroteskNextWeb-MedExt", size: 12.0)!
  }

  class var link: UIFont {
    return UIFont(name: "AkGroteskNextWeb-MedExt", size: 12.0)!
  }

  class var more: UIFont {
    return UIFont(name: "AkGroteskNextWeb-MedExt", size: 12.0)!
  }

  class var subheads: UIFont {
    return UIFont(name: "AkGroteskNextWeb-MedExt", size: 12.0)!
  }

  class var unitSelected: UIFont {
    return UIFont(name: "AkGroteskNextWeb-MedExt", size: 12.0)!
  }

  class var unitUnselected: UIFont {
    return UIFont(name: "AkGroteskNextWeb-MedExt", size: 12.0)!
  }

  class var error: UIFont {
    return UIFont(name: "AkGroteskNextWeb-Regular", size: 12.0)!
  }

  class var AKRegularParagraphStyle: UIFont {
    return UIFont(name: "AkGroteskNextWeb-RegularExt", size: 12.0)!
  }

  class var captionStyle: UIFont {
    return UIFont(name: "Roboto-Regular", size: 12.0)!
  }

  class var title2FormerlyZ3SubtitleUppercaseGrey: UIFont {
    return UIFont(name: "Roboto-Regular", size: 12.0)!
  }

  class var body2BoldFormerlyZDetails: UIFont {
    return UIFont(name: "Roboto-Bold", size: 11.0)!
  }

  class var buttonSelected: UIFont {
    return UIFont(name: "AkGroteskNextWeb-MedExt", size: 11.0)!
  }
    class var buttonNormal: UIFont {
        return UIFont(name: "AkGroteskNextWeb-RegularExt", size: 11.0)!
    }

  class var buttonUnselected: UIFont {
    return UIFont(name: "AkGroteskNextWeb-MedExt", size: 11.0)!
  }

  class var feedBodyCopy: UIFont {
    return UIFont(name: "AkGroteskNextWeb-Regular", size: 11.0)!
  }

  class var body2FormerlyZDetails: UIFont {
    return UIFont(name: "Roboto-Regular", size: 11.0)!
  }

  class var privacy: UIFont {
    return UIFont(name: "Roboto-Regular", size: 11.0)!
  }

  class var body3: UIFont {
    return UIFont(name: "Roboto-Regular", size: 10.0)!
  }

  class var description: UIFont {
    return UIFont(name: "AkGroteskNextWeb-RegularExt", size: 9.5)!
  }

  class var fitDescription: UIFont {
    return UIFont(name: "AkGroteskNextWeb-RegularExt", size: 9.5)!
  }

    class func printAll() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }

    }
}
