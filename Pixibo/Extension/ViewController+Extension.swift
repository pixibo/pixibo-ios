//
//  ViewController+Extension.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/24/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    
    func addRightBarButton(_ image: String, _ target: Any, action: Selector) {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: image), for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0)
        button.addTarget(target, action: action, for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = barButtonItem
        
    }

    func addLeftBarButton(_ image: String, _ target: Any, action: Selector) {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: image), for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0)
        button.addTarget(target, action: action, for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    func setBackgroundColor() {
        self.view.backgroundColor = UIColor.white
    }
}

extension UIView {
    
    func findFirstResponder() -> UIView? {
        if isFirstResponder { return self }
        for subView in subviews {
            if let firstResponder = subView.findFirstResponder() {
                return firstResponder
            }
        }
        return nil
    }
}
