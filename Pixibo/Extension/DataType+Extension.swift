//
//  DataType+Extension.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 2/3/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import Foundation

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var floatValueTwo: String {
        return String(format: "%.2f", self.floatValue)

    }    
}

extension Float {

    var toKg: Float {
        return self * 0.45359237
    }
    
    var toLb: Float {
        return self * 2.20462
    }

}
extension Array {
    func index(of anObject:Any) -> Int {
        let array: NSArray = self._bridgeToObjectiveC()
        return array.index(of: anObject)
    }
}
