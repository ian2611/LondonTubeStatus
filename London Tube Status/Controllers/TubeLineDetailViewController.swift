//
//  TubeLineDetailViewController.swift
//  London Tube Status
//
//  Created by Ian Billings on 19/11/2017.
//  Copyright © 2017 Ian Billings. All rights reserved.
//

import UIKit

class TubeLineDetailViewController: UIViewController {
    
    var status: TubeLineStatus?
    var lastUpdated: Date?

    @IBOutlet weak var lineNameLabel: UILabel!
    @IBOutlet weak var messageLabel: TopAlignedLabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let status = status {
            
            lineNameLabel.text = status.line.standardName
            let colours = status.line.getColours()
            lineNameLabel.backgroundColor = colours.lineColour
            lineNameLabel.textColor = colours.fontColour
            
            if status.status == .goodService {
                messageLabel.text = "There is currently a good service operating on the \(status.line.fullTitle)."
            } else {
                messageLabel.text = status.message
            }
            
            if let lastUpdated = lastUpdated {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                dateFormatter.timeStyle = .short
                dateFormatter.locale = Locale.current
                lastUpdatedLabel.text = dateFormatter.string(from: lastUpdated)
            }
            
        }

       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
