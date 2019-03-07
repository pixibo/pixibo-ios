//
//  PXConstant.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/26/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

struct PXConstant {
    
    struct StoryBoard {
        static let name = "Main"
    }
    
    struct ViewControllerID {
        static let PXBodyProfileViewController = "PXBodyProfileViewController"
        static let PXFitPreferenceViewController = "PXFitPreferenceViewController"
        static let PXResultViewController = "PXResultViewController"
    }
    
    enum firPrefType: String {
        case PXTight = "1"
        case PXRegular = "2"
        case PXLoose = "3"
        var value: String {
            switch self {
            case .PXTight: return "Tight"
            case .PXRegular: return "Regular"
            case .PXLoose: return "Loose"
            }
        }
    }

    
    enum cellType: Int {
        case PXBodyProfileHeight = 0
        case PXBodyProfileWeight = 1
        case PXBodyFitPref = 2
        case PXBodySizeResult = 3
        case Unknown = 4
        
    }
    
    
}


