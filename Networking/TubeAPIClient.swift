//
//  TubeAPIClient.swift
//  London Tube Status
//
//  Created by Ian Billings on 19/11/2017.
//  Copyright © 2017 Ian Billings. All rights reserved.
//

import Foundation


class TubeAPIClient {
    
    
    let jsonDownloader = JSONDownloader()
    
    
    typealias CurrentStatusCompletionHandler = ([TubeLine: TubeLineStatus]?, TubeError?) -> Void
    
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
    
    
    
    
    
    
    
//    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
//
//        guard let url = URL(string: coordinate.description, relativeTo: baseUrl) else {
//            completion(nil, .invalidURL)
//            return
//        }
//
//        let request = URLRequest(url: url)
//
//        let task = downloader.jsonTask(with: request) { json, error in
//
//            DispatchQueue.main.async {
//                guard let json = json else {
//                    completion(nil, error)
//                    return
//                }
//
//                guard let currentWeatherJson = json["currently"] as? [String: AnyObject], let currentWeaher = CurrentWeather(json: currentWeatherJson) else {
//                    completion(nil, .jsonParsingFailure)
//                    return
//                }
//
//                completion(currentWeaher, nil)
//
//            }
//
//
//        }
//
//        task.resume()
//
//    }
    
    
}
