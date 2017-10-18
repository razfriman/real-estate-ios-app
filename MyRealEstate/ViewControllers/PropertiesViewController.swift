//
//  PropertiesViewController.swift
//  MyRealEstate
//
//  Created by Raz Friman on 10/20/15.
//  Copyright © 2015 Raz Friman. All rights reserved.
//

import Foundation
import UIKit

class PropertiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect the refresh control
        self.tableView.addSubview(self.refreshControl)
        handleRefresh(refreshControl)
    }
    
    // Lazy instaniate a UIRefreshControl for "pull-to-refresh"
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
        }()
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Reload data
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of properties
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Deselect the row on the table
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Nothing
    }
    
    @IBOutlet weak var tableView: UITableView!
}