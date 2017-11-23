//
//  TubeLinesTableViewController.swift
//  London Tube Status
//
//  Created by Ian Billings on 18/11/2017.
//  Copyright © 2017 Ian Billings. All rights reserved.
//

import UIKit
class TubeLinesTableViewController: UITableViewController {

    let dataSource = TubeLineDataSource()
    
    let apiClient = TubeAPIClient()
    
    lazy var cellHeight: CGFloat = {
        let MinHeight: CGFloat = 30.0
        let topSpace: CGFloat = 44.0
        let topBarHeight: CGFloat
        let tHeight: CGFloat
        
        let deviceHeight = UIScreen.main.bounds.height > UIScreen.main.bounds.width ? UIScreen.main.bounds.height : UIScreen.main.bounds.width
        
        if deviceHeight == 812.0 {
            topBarHeight = topSpace + 40.0
        } else {
            topBarHeight = topSpace + 20.0
        }
        
        tHeight = deviceHeight - topBarHeight
        
        
        let temp = tHeight/CGFloat(dataSource.count)
        
        return temp > MinHeight ? temp : MinHeight
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = dataSource
       
        tableView.separatorStyle = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name("UpdatedData"), object: nil)
        self.refreshControl?.addTarget(self, action: #selector(TubeLinesTableViewController.updateLineStatus(refreshControl:)), for: UIControlEvents.valueChanged)
        
        //dataSource.update(status: Stub.TubeLineDictionary())
        //tableView.reloadData()
        self.updateLineStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func reloadTableView() {
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lineDetail" {
            let detailVC = segue.destination as? TubeLineDetailViewController
            let lineStatus = dataSource.getTubeLineStatusFor(indexPath: tableView.indexPathForSelectedRow!)
            detailVC?.status = lineStatus
            detailVC?.lastUpdated = dataSource.lastUpdated
        }
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
    
    @objc func updateLineStatus(refreshControl: UIRefreshControl) {
        self.updateLineStatus()
        refreshControl.endRefreshing()
    }
    
    func showAlertWith(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
  
    
}
