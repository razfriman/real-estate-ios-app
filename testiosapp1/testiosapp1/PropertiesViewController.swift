//
//  PropertiesViewController.swift
//  testiosapp1
//
//  Created by Raz Friman on 9/14/15.
//  Copyright (c) 2015 Raz Friman. All rights reserved.
//

import Foundation
import UIKit

class PropertiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    //let data = ["5600 SMU Blvd","8088 Park Ln","4704 Abbot Ave"]
    let percents = [0.25, 1.0, 0.80]
    var data = [Property]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
        }()
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Reload data
        if let userId = ApiManager.sharedInstance.loadFromKeychain(ApiManager.USER_ID_KEY_NAME) {
            
            ApiManager.sharedInstance.loadUserProperties(userId)
                .validate()
                .responseCollection { (_, _, result: Result<[Property]>) in
                    switch(result) {
                    case .Success:
                        
                        if let properties = result.value {
                            self.data = properties
                        }
                        
                        self.tableView.reloadData()
                        refreshControl.endRefreshing()
                        
                    case .Failure(_, let error):
                        print(error)
                        self.showAlertMessage("ERROR", message: "Cannot Load Properties")
                        
                        self.tableView.reloadData()
                        refreshControl.endRefreshing()
                        
                    }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.addSubview(self.refreshControl)
        handleRefresh(refreshControl)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let property = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("propertyCell", forIndexPath: indexPath) as! PropertyCell
        cell.addressLabel.text = property.address
        cell.titleLabel.text = property.title ?? property.address
        cell.leftImageView.image = UIImage(named: "placeholderPropertyIcon")
        
        let progress = Float(arc4random()) / 0xFFFFFFFF
        cell.progressView.setProgress(progress, animated: false)
        
        request(.GET, property.image).response { (request, response, data, error) in
            cell.leftImageView.image = UIImage(data: data!, scale:1)
        }
        
        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        print("Selected: \(indexPath.row)")
    }
    
    @IBOutlet weak var tableView: UITableView!
}