//
//  TVTubeLineTableViewController.swift
//  London Tube Status TV
//
//  Created by Ian Billings on 27/12/2017.
//  Copyright © 2017 Ian Billings. All rights reserved.
//

import UIKit

class TVTubeLineTableViewController: UITableViewController {
    
    let dataSource = TubeLineDataSource()
    
    let apiClient = TubeAPIClient()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = dataSource
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name("UpdatedData"), object: nil)
        
        self.updateLineStatus()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func reloadTableView() {
        self.tableView.reloadData()
    }

    func updateLineStatus() {
        
        apiClient.getCurrentLineStatus { currentStatus, error in
            guard let currentStatus = currentStatus else {
                
                if let tubeError = error {
                    
                    switch tubeError {
                        
                    case .requestFailed, .responseUnsuccessful: self.showAlertWith(title: "Request Failed", message: "There was an error contacting the server. Please check you connection and try again. If this problem persists, please contact support")
                    default: self.showAlertWith(title: "Error", message: "Error reading data. If this error persists please contact support.")
                        
                    }
                    
                    
                }
                
                
                return
            }
            self.dataSource.update(status: currentStatus)
            //self.dataSource.lastUpdated = Date()
            self.reloadTableView()
        }
        
        
    }
    
    func showAlertWith(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
