//
//  PXResultModel.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 2/19/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXResultModel {
    
    var resultArr = [fys]()
    var gcount = 0
    var type: String?
    
    init(json: Dictionary<String, Any>) {
        if let f = json["fys"] as? [Dictionary<String, Any>]{
            for each in f {
                self.resultArr.append(fys(json: each))
            }
        }
        if let gcount = json["gcount"] as? Int{
            self.gcount = gcount
        }
        
        if let type = json["type"] as? String{
            self.type = type
        }
    }
}


struct fys {
    var bustCode: Int?
    var waistCode: Int?
    var hipCode: Int?
    var bustMedian: Int?
    var waistMedian: Int?
    var hipMedian: Int?
    var recommended: Int?
    var size: String?
    var confidence: Int?
    
    init(json: Dictionary<String, Any>) {
        if let bcode = json["bust"] as? Int{
            self.bustCode = bcode
        }
        
        if let waistCode = json["waist"] as? Int{
            self.waistCode = waistCode
        }
        
        if let hipCode = json["hip"] as? Int{
            self.hipCode = hipCode
        }
        
        if let bustMedian = json["bust8Bit"] as? Int{
            self.bustMedian = bustMedian
        }
        
        if let waistMedian = json["waist8Bit"] as? Int{
            self.waistMedian = waistMedian
        }
        
        if let hipMedian = json["hip8Bit"] as? Int{
            self.hipMedian = hipMedian
        }
        
        if let recommended = json["recommended"] as? Int{
            self.recommended = recommended
        }
        
        if let size = json["size"] as? String{
            self.size = size
        }
        if let confidence = json["confidence"] as? Int{
            self.confidence = confidence
        }
    }
}
