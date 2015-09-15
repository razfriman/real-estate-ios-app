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
    
    func checkValidInputFields() -> Bool {
        
        
        if(!validateEmail(emailTextField.text)) {
            // Invalid email
            showAlertMessage("Error", message: "Invalid email address")
            return false
        }
        
        if(passwordTextField.text == nil || passwordTextField.text?.characters.count == 0) {
            // Password is required
            showAlertMessage("Error", message: "Password is required")
            return false
        }
        
        return true
    }
    
    @IBAction func loginClicked(sender: AnyObject) {
        
        if(!checkValidInputFields()) {
            return
        }
        
        // Login through the API manager
        ApiManager.sharedInstance.login(emailTextField.text!, password: passwordTextField.text!)
            .validate()
            .responseJSON { _, _, result in
                
                switch(result) {
                case .Success:
                    // Successful login
                    
                    // Save the JWT token to the keychain
                    let json = result.value as? NSDictionary // info will be nil if it's not an NSDictionary
                    let token = json?["token"] as? String
                    let userId = json?["id"] as? String
                    let email = json?["email"] as? String
                    
                    ApiManager.sharedInstance.saveToKeychain(ApiManager.JWT_TOKEN_KEY_NAME, value: token!)
                    ApiManager.sharedInstance.saveToKeychain(ApiManager.USER_ID_KEY_NAME, value: userId!)
                    ApiManager.sharedInstance.saveToKeychain(ApiManager.EMAIL_KEY_NAME, value: email!)
                    
                    // Perform the segue to move to the main screen of the app
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                    
                case .Failure(_, let error):

                    print(error)
                    // Invalid email/password
                    self.showAlertMessage("Error", message: "Invalid email/password")
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

