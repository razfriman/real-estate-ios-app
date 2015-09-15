//
//  LoginViewController.swift
//  testiosapp1
//
//  Created by Raz Friman on 9/4/15.
//  Copyright (c) 2015 Raz Friman. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Assign text field delegates to this class
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginClicked(sender: AnyObject) {
        
        // Login through the API manager
        ApiManager.sharedInstance.login(emailTextField.text!, password: passwordTextField.text!)
            .validate()
            .responseString { _, _, result in
                
                switch(result) {
                case .Success:
                    // Successful login
                    
                    // Save the JWT token to the keychain
                    ApiManager.sharedInstance.saveToKeychain(result.value!)
                    
                    // Perform the segue to move to the main screen of the app
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                    
                case .Failure(_, let error):

                    // Invalid email/password
                    print(error)

                    let alertController = UIAlertController(title: "Cannot login", message:
                        "Invalid email/password", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
        }
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
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func unwindToLoginScreen(segue: UIStoryboardSegue) {
        
    }
}

