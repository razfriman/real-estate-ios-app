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
    
    var tableView:UITableView?
    var properties = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.properties.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CELL")
        }
        
        let user:JSON =  JSON(self.properties[indexPath.row])
        
        let picURL = user["picture"]["medium"].string
        let url = NSURL(string: picURL!)
        let data = NSData(contentsOfURL: url!)
        
        cell!.textLabel?.text = user["username"].string
        cell?.imageView?.image = UIImage(data: data!)
        
        return cell!
    }
}