//
//  TubeLine.swift
//  London Tube Status
//
//  Created by Ian Billings on 18/11/2017.
//  Copyright © 2017 Ian Billings. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
}



enum TubeLine {
    
    case bakerloo
    case central
    case circle
    case district
    case dlr
    case hammersmith
    case jubilee
    case metropolitan
    case northern
    case overground
    case piccadilly
    case tflRail
    case trams
    case victoria
    case waterloo
    
    
    
    
    var isLine: Bool {
        
        switch self {
        case .dlr, .overground, .tflRail, .trams: return false
            
        default: return true
        }
        
    }
    
    var standardName: String {
        switch self {
        case .bakerloo: return "Bakerloo"
        case .central: return "Central"
        case .circle: return "Circle"
        case .district: return "District"
        case .dlr: return "DLR"
        case .hammersmith: return "Hammersmith & City"
        case .jubilee: return "Jubilee"
        case .metropolitan: return "Metropolitan"
        case .northern: return "Northern"
        case .overground: return "Overground"
        case .piccadilly: return "Piccadilly"
        case .tflRail: return "TfL Rail"
        case .trams: return "Trams"
        case .victoria: return "Victoria"
        case .waterloo: return "Waterloo & City"
        }
        
    }
    
    var fullTitle: String {
        if self.isLine {
            return "\(standardName) line"
        } else {
            return standardName
        }
    }
    
    var shortenedName: String {
        switch self {
        case .hammersmith: return "H'smith & City"
        case .waterloo: return "W'loo & City"
        default: return standardName
        }
    }
    
    
    init?(lineName: String) {
        
        switch lineName.lowercased() {
        case "bakerloo", "bakerloo line": self = .bakerloo
        case "central", "central line": self = .central
        case "circle", "circle line": self = .circle
        case "district", "district line": self = .district
        case "dlr", "docklands light railway": self = .dlr
        case "hammersmith", "hammersmith & city", "hammersmith and city", "hammersmith & city line", "hammersmith and city line", "hammersmith-city": self = .hammersmith
        case "jubilee", "jubilee line": self = .jubilee
        case "metropolitan", "metropolitan line": self = .metropolitan
        case "northern", "northern line": self = .northern
        case "overground", "london-overground": self = .overground
        case "piccadilly", "piccadilly line": self = .piccadilly
        case "tfl rail", "tfl-rail": self = .tflRail
        case "trams", "tram": self = .trams
        case "victoria", "victoria line": self = .victoria
        case "waterloo", "waterloo and city", "waterloo and city line", "waterloo & city", "waterloo & city line", "waterloo-city": self = .waterloo
            
        default: return nil
        }
        
        
        
    }
    
    
    
    
    func getColourForLine() -> UIColor {
        switch self {
            
        case .bakerloo: return UIColor(red: 178, green: 99, blue: 0)
        case .central: return UIColor(red: 220, green: 36, blue: 31)
        case .circle: return UIColor(red: 255, green: 211, blue: 41)
        case .district: return UIColor(red: 0, green: 125, blue: 50)
        case .dlr: return UIColor(red: 0, green: 175, blue: 173)
        case .hammersmith: return UIColor(red: 244, green: 169, blue: 190)
        case .jubilee: return UIColor(red: 161, green: 165, blue: 167)
        case .metropolitan: return UIColor(red: 155, green: 0, blue: 88)
        case .northern: return UIColor(red: 0, green: 0, blue: 0)
        case .overground: return UIColor(red: 239, green: 123, blue: 16)
        case .piccadilly: return UIColor(red: 0, green: 25, blue: 168)
        case .tflRail: return UIColor(red: 0, green: 25, blue: 168)
        case .trams: return UIColor(red: 0, green: 189, blue: 25)
        case .victoria: return UIColor(red: 0, green: 152, blue: 216)
        case .waterloo: return UIColor(red: 147, green: 206, blue: 186)
            
        }
    }
    
    func getFontColourForLine() -> UIColor {
        
        switch self {
        case .circle, .hammersmith, .waterloo: return UIColor(red: 17, green: 56, blue: 146)
            
        default: return UIColor.white
            
        }
    }
    
    func getColours() -> (lineColour: UIColor, fontColour: UIColor) {
        return (getColourForLine(), getFontColourForLine())
    }
  
    
}
