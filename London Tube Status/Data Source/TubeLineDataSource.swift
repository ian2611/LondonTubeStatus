//
//  TubeLineDataSource.swift
//  London Tube Status
//
//  Created by Ian Billings on 18/11/2017.
//  Copyright © 2017 Ian Billings. All rights reserved.
//

import Foundation
import UIKit


class TubeLineDataSource: NSObject, UITableViewDataSource {
    
    private var currentStatus = [TubeLine: TubeLineStatus]() {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name("UpdatedData") , object: nil)
            self.lastUpdated = Date()
        }
    }
    private let lines: [TubeLine] = [.bakerloo, .central, .circle, .district, .dlr, .hammersmith, .jubilee, .metropolitan, .northern, .overground, .piccadilly, .tflRail, .trams, .victoria, .waterloo]
    
    
    var lastUpdated: Date?
    
    var count: Int {
        return currentStatus.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TubeCell") as! TubeCell
        
        let line = lines[indexPath.row]
        let colours = line.getColours()
        
        if let lineStatus = currentStatus[line] {
            cell.statusLabel.text = lineStatus.status.statusText
            
            if lineStatus.status != .goodService {
                cell.statusLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
            } else {
                cell.statusLabel.font = UIFont.systemFont(ofSize: 13.0)
            }
            
        } else {
            cell.statusLabel.text = "No Data"
        }
        
        
        cell.lineNameLabel.text = line.standardName
        cell.backgroundColor = colours.lineColour
        cell.lineNameLabel.textColor = colours.fontColour
        cell.statusLabel.textColor = colours.fontColour
        
        return cell
    }
    
    
    func getStatusForLine(line: TubeLine) -> TubeLineStatus? {
        return currentStatus[line]
    }
    
    func getTubeLineStatusFor(indexPath: IndexPath) -> TubeLineStatus? {
        return currentStatus[lines[indexPath.row]]
    }
    
    func update(status: TubeLineStatus, forKey key: TubeLine) {
        currentStatus[key] = status
    }
    
    func update(status: [TubeLine: TubeLineStatus]) {
        self.currentStatus = status
    }
    
}
