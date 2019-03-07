//
//  PXWebServiceManager.swift
//  Pixibo
//
//  Created by Karthik Srinivasan on 1/26/19.
//  Copyright © 2019 Pixibo. All rights reserved.
//

import UIKit

class PXWebServiceManager: NSObject {

    static let sharedManager  = PXWebServiceManager()
    
    lazy var sessionManager: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.urlCache = nil
        sessionConfig.timeoutIntervalForRequest = TimeInterval(60)
        sessionConfig.timeoutIntervalForResource = TimeInterval(60)
        return  URLSession(configuration: sessionConfig)
    }()
    
    private override init() {
        super.init()
    }
    
    func getSizeRecommendation(params: [String: String], onCompletion : @escaping PXAPIConstant.responseBlock) {
        let url = PXAPIConstant.BASE_URL
        
        let request = self.prepareGetRequest(url: url, params: params)
        requestServerWith(request: request) { (response, error) in
            onCompletion(response, error)
        }
    }

}

private extension PXWebServiceManager {

    private func requestServerWith(request : URLRequest, onCompletion : @escaping PXAPIConstant.responseBlock) {
        let dataTask =  sessionManager.dataTask(with: request) { (data, response, error) in
            // 1: Check HTTP Response for successful GET request
            guard let httpResponse = response as? HTTPURLResponse, let _ = data
                else { return onCompletion(nil, error)}
            switch (httpResponse.statusCode)
            {
            case PXAPIConstant.httpsStatusCode.ok:
                let json: NSDictionary?
                do {
                    json = try JSONSerialization.jsonObject(
                        with: data!,
                        options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                } catch {
                    print("Serialisation error")
                    return
                }
                print("json: \(String(describing: json))")

                onCompletion(json, nil)
                break
            case PXAPIConstant.httpsStatusCode.pageNotFound:
                onCompletion(nil, error)
                break
            default:
                onCompletion(nil, error)
            }
        }
        dataTask.resume()
    }
}

private extension PXWebServiceManager {
    
    func preparePostRequest() {
        
    }

    func prepareGetRequest(url: String, params: [String: String]) -> URLRequest {
        var modifiedParam = params
        modifiedParam["uid"] = PXUtility.getUniqueID()
        modifiedParam["altId"] = PXUtility.getUniqueID()
        
        var components = URLComponents(string: url)!
        components.queryItems = modifiedParam.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url!)
        request.httpMethod = PXAPIConstant.httpsMethodType.get
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        print("Data: \(String(describing: request))")
        print("Header: \(String(describing: request.allHTTPHeaderFields))")
        
        return request
    }

}
