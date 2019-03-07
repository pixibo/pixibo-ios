//
//  PRBodyProfileModel.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 2/2/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

struct PRBodyHeightModel {
    var title: String
    var cmRange: [Double]
//    var feetRange: [String] = []
    
    init(json: [String: AnyObject]) {
        self.title  = json["title"] as! String
        self.cmRange = json["cm"] as! [Double]
//        for each in self.cmRange {
//          self.feetRange.append(PXUtility.convertFootAndInchesFromCm(each))
//        }
    }
}

struct PRBodyWeightModel {
    var title: String?
    var kgRange: [Double]
    var lbsRange: [Double]
    
    init(json: [String: AnyObject]) {
        self.title  = json["title"] as? String
        self.kgRange  = json["kg"]  as! [Double]
        self.lbsRange  = json["lbs"]  as! [Double]
    }
}

struct PRBodyBraSizeModel {
    var title: String = ""
    var type: [String] = []
    var band: [String : AnyObject] = [:]
    var cup: [String : AnyObject] = [:]
    
    init(json: [String: AnyObject]) {
        if let title = json["title"] {
            self.title  = (title as? String)!
        }
        
        if let type = json["type"] {
            self.type  = (type as? [String])!
        }
        
        if let band = json["band"] {
            self.band  = (band as? [String : AnyObject])!
        }
        
        if let cup = json["cup"] {
            self.cup  = (cup as? [String : AnyObject])!
        }
    }
}


struct PRBodyProfileModel {
    
    var height: PRBodyHeightModel?
    var weight: PRBodyWeightModel?
    var braSize: PRBodyBraSizeModel?
    
    init(json: [String: AnyObject]) {
        guard let validJson = json["data"] else { return }
        
        if let heightJson  = validJson["height"], let heightJ = heightJson as? [String: AnyObject] {
            self.height = PRBodyHeightModel(json: heightJ)
        }

        if let weightJson  = validJson["weight"], let weightJ = weightJson as? [String: AnyObject] {
            self.weight = PRBodyWeightModel(json: weightJ)
        }
        
        if let braSize  = validJson["braSize"], let weightJ = braSize as? [String: AnyObject] {
            self.braSize = PRBodyBraSizeModel(json: weightJ)
        }
    }
    
}
