//
//  LoginViewController.swift
//  MyRealEstate
//
//  Created by Raz Friman on 10/20/15.
//  Copyright © 2015 Raz Friman. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func loginClicked(sender: AnyObject) {
            
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if(textField == emailTextField) {
            // Move from Email to Password text field
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if (textField == passwordTextField) {
            // "Go" button pressed on the password field
            // perform the login
            passwordTextField.resignFirstResponder()
            loginClicked(self)
        }
        return true
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Hide the keyboard when touching away from the textfield
        self.view.endEditing(true)
    }
    
    @IBAction func unwindToLoginScreen(segue: UIStoryboardSegue) {
        
    }
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
}