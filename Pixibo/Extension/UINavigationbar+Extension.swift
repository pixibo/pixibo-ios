//
//  UINavigationbar+Extension.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/30/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func navigationBarSetup() {
        self.barTintColor =  UIColor.white
        self.tintColor    = UIColor.pureBlue
//        self.shadowImage = UIImage()
        self.isTranslucent = false
        self.titleTextAttributes = [NSAttributedString.Key.font: UIFont.navigationTitle,
                                    NSAttributedString.Key.foregroundColor: UIColor.black]
        
    }
    
}

extension UIBarButtonItem {
    
    var frame: CGRect? {
        guard let view = self.value(forKey: "view") as? UIView else {
            return nil
        }
        return view.frame
    }
    
    var view: UIView? {
        guard let view = self.value(forKey: "view") as? UIView else {
            return nil
        }
        return view
    }

    
}
