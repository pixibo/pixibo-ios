//
//  PXLoaderManager.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 2/9/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXLoaderManager {
    
    static let sharedManager  = PXLoaderManager()
    let loaderView = PXLoaderView(frame: UIScreen.main.bounds)
    let animatedLoaderView = PXAnimatedLoaderView(frame: UIScreen.main.bounds)
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(loaderView)
    }

    func hide() {
        DispatchQueue.main.async {
            self.loaderView.removeFromSuperview()
        }
    }
    
    func showAnimated() {
        UIApplication.shared.keyWindow?.addSubview(animatedLoaderView)
    }
    
    func hideAnimated() {
        DispatchQueue.main.async {
            self.animatedLoaderView.removeFromSuperview()
        }
    }
}
