//
//  JSONDownloader.swift
//  London Tube Status
//
//  Created by Ian Billings on 19/11/2017.
//  Copyright © 2017 Ian Billings. All rights reserved.
//

import Foundation

/*
 Class reponsible for Downloading JSON data from TfL API
 */
class JSONDownloader {
    
    
    let url = URL(string: "https://api.tfl.gov.uk/line/Mode/tube%2Cdlr%2Coverground%2Ctflrail%2Ctram")
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    
    typealias JSON = [AnyObject]
    typealias JSONTaskCompletionHandler = (JSON?, TubeError?) -> Void
    
    /*
     This function takes a URL request and a completion handler that takes optional JSON and optional error.
     The function then passes either the resulting JSON or the error to the completion handler.
     The function returns a URLSessionDataTask.
    */
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject]
                        completion(json, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
            
        }
        
        return task
    }
    
    
}
