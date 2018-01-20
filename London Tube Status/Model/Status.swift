//
//  Status.swift
//  London Tube Status
//
//  Created by Ian Billings on 18/11/2017.
//  Copyright © 2017 Ian Billings. All rights reserved.
//

import Foundation


enum Status {
    
    case goodService
    case suspended
    case partSuspended
    case serviceClosed
    case minorDelays
    case severeDelays
    case plannedClosure
    case partClosure
    case specialService
    
    
    // A computed property that returns the String representation of the service status.
    var statusText: String {
        
        switch self {
            
        case .goodService: return "Good Service"
        case .suspended: return "Suspended"
        case .partSuspended: return "Part Suspended"
        case .serviceClosed: return "Service Closed"
        case .minorDelays: return "Minor Delays"
        case .severeDelays: return "Severe Delays"
        case .plannedClosure: return "Planned Closure"
        case .partClosure: return "Part Closure"
        case .specialService: return "Special Service"
        }
    }
    
    
    // A failable initialiser that takes a String, and if possible returns a valid Status object. Otherwise it returns nil.
    init?(status: String) {
        
        switch status.lowercased() {
        case "good service": self = .goodService
        case "suspended": self = .suspended
        case "part suspended": self = .partSuspended
        case "closed", "service closed": self = .serviceClosed
        case "minor delays": self = .minorDelays
        case "severe delays": self = .severeDelays
        case "planned closure": self = .plannedClosure
        case "part closure": self = .partClosure
        case "special service": self = .specialService
        default: return nil
        }
        
        
        
        
    }
    
    
}
