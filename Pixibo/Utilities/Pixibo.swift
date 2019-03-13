//
//  Pixibo.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 3/7/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class Pixibo {
    
    class func initialize(forClientId: String, withAltId: String? = nil) {
        PXAPIConstant.clientID = forClientId
        PXAPIConstant.altID = withAltId
    }
    
    class func presentFyf(withSKUId: String, withAltId: String? = nil) {
        PXAPIConstant.skuID = withSKUId
        PXAPIConstant.altID = withAltId
        
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
                PXWebServiceManager.sharedManager.fireEvent(onCompletion: { (response, error) in
                    
                })
            }
        }
    }
    
}
