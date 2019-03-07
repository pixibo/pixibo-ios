//
//  Pixibo.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 3/7/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class Pixibo {
    
    class func initialize(forClientId: String) {
        PXAPIConstant.clientID = forClientId
    }
    
    class func presentFyf(withSKUId: String) {
        PXAPIConstant.skuID = withSKUId
        if let _ = PXAPIConstant.clientID,
            let _ = PXAPIConstant.skuID{
            PXWebServiceManager.sharedManager.validateSKUId(params: [:]) { (response, error) in
                DispatchQueue.main.async {
                    if error == nil {
                        PXUtility.loadPixiboController()
                    } else {
                        PXUtility.addAlert()
                    }
                }
            }
        }
    }
    
}
