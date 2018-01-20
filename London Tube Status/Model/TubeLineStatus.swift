//
//  TubeLineStatus.swift
//  London Tube Status
//
//  Created by Ian Billings on 18/11/2017.
//  Copyright © 2017 Ian Billings. All rights reserved.
//

import Foundation


class TubeLineStatus {
    
    let line: TubeLine
    
    let status: Status
    
    let message: String
    
    
    
    
    init(line: TubeLine, status: Status, message: String) {
        self.line = line
        self.status = status
        self.message = message
    }
    
    
    
    // A failable initialiser that takes a JSON data. If that data represents a TubeLineStatus, it returns a TubeLineStatus object, otherwise it returns nil.
    init?(json: [String : AnyObject]) {
//        print("*******************************")
//        print(json)
//        print("*******************************")
        guard let lineName = json["id"] as? String else {
            return nil
        }
        
        guard let line = TubeLine(lineName: lineName) else {
            return nil
        }
        
        guard let lineDetail = json["lineStatuses"] as? [AnyObject] else {
            return nil
        }
        
        guard let lineStatuses = lineDetail[0] as? [String: AnyObject] else {
            return nil
        }
        
        guard let lineStatus = lineStatuses["statusSeverityDescription"] as? String else {
            return nil
        }
        
        guard let status = Status(status: lineStatus) else {
            return nil
        }
        
        self.line = line
        self.status = status
        
        if let lineMessage = lineStatuses["reason"] as? String {
            self.message = lineMessage
        } else {
            self.message = ""
        }
        
    }
    
    
}
