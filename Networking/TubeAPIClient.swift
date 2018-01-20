//
//  TubeAPIClient.swift
//  London Tube Status
//
//  Created by Ian Billings on 19/11/2017.
//  Copyright © 2017 Ian Billings. All rights reserved.
//

import Foundation

/*
 Class for TfL API Client request
 */
class TubeAPIClient {
    
    
    let jsonDownloader = JSONDownloader()
    
    
    typealias CurrentStatusCompletionHandler = ([TubeLine: TubeLineStatus]?, TubeError?) -> Void
    
    /*
     This function requests the JSON data from the API and converts it in TubeLineStatus Objects are then passed to the completion handler
    */
    func getCurrentLineStatus(completionHandler completion: @escaping CurrentStatusCompletionHandler) {
        
        guard let url = URL(string: "https://api.tfl.gov.uk/line/Mode/tube%2Cdlr%2Coverground%2Ctflrail%2Ctram/status") else {
            completion(nil, .invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = jsonDownloader.jsonTask(with: request) { json, error in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                
                var currentStatus = [TubeLine: TubeLineStatus]()
                
                for jsonItem in json {
                    guard let jsonDict = jsonItem as? [String: AnyObject] else {
                        completion(nil, error)
                        return
                    }
                    
                    guard let tubeStatus = TubeLineStatus(json: jsonDict) else {
                        completion(nil, error)
                        return
                    }
                    
                    currentStatus[tubeStatus.line] = tubeStatus
                    
                }
                completion(currentStatus, nil)
                
            }
        }
        task.resume()
        
    }

}
