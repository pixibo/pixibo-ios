//
//  PXAPIConstant.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/26/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

struct PXAPIConstant {
    
    static var BASE_URL:String = "http://sizeguidev2.pixibo.com/"
    static var asset = "asset/"
    static var event = "event/"
    static var skuID: String!
    static var clientID: String!
    static var altID: String?
    
    static func getBaseUrl() -> String{
        return PXAPIConstant.BASE_URL + asset + clientID + "/" + skuID
    }
    static func getEventBaseUrl() -> String{
        return PXAPIConstant.BASE_URL + event + clientID + "/" + skuID
    }
    static func getAltId() -> String? {
        return altID
    }
    
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
