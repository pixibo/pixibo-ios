//
//  PXAPIConstant.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/26/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

struct PXAPIConstant {
    
    static let BASE_URL:String = "http://sizeguidev2.pixibo.com/asset/qxfgc8rhrozb/22578"
    
    typealias responseBlock = (_ result: AnyObject?, _ error: Error?) -> Void
    
    struct httpsMethodType  {
        static let post = "POST"
        static let get = "GET"
    }
    
    struct httpsStatusCode {
        static let ok = 200
        static let content = 204
        static let multipleChoices = 300
        static let movedPermanently = 301
        static let found = 302
        static let codeNotModified = 304
        static let codeMovedTemporarily = 307
        static let pageNotFound = 400
        static let notFound = 404
        static let cannotAcceptTraffic = 429
        static let unavailable = 503
    }
    
    
}
