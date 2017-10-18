//
//  ProfileViewController.swift
//  MyRealEstate
//
//  Created by Raz Friman on 10/20/15.
//  Copyright © 2015 Raz Friman. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func logoutClicked(sender: AnyObject) {
        
        // Clear the login token
        // TODO
        
        // Return to the login screen
        self.setRootViewController("LoginViewController")
    }
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
}