//
//  Stub.swift
//  London Tube Status
//
//  Created by Ian Billings on 18/11/2017.
//  Copyright © 2017 Ian Billings. All rights reserved.
//

import Foundation


class Stub {
    
    static let lines: [TubeLine] = [.bakerloo, .central, .circle, .district, .dlr, .hammersmith, .jubilee, .metropolitan, .northern, .overground, .piccadilly, .tflRail, .trams, .victoria, .waterloo]
    
    static func TubeLineDictionary() -> [TubeLine: TubeLineStatus] {
       
        var result = [TubeLine: TubeLineStatus]()
        
        for line in lines {
            let lineStatus = TubeLineStatus(line: line, status: .goodService, message: "")
            result[line] = lineStatus
        }
        return result
    }
    
}
