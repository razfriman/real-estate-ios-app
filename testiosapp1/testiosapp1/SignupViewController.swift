//
//  SignupViewController
//  testiosapp1
//
//  Created by Raz Friman on 9/4/15.
//  Copyright (c) 2015 Raz Friman. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func checkValidInputFields() -> Bool {
        
        if(!validateEmail(emailTextField.text)) {
            // Invalid email
            showAlertMessage("Error", message: "Invalid email address")
            return false
        }
        
        if(passwordTextField.text == nil || passwordTextField.text?.characters.count == 0) {
            // Password is required
            showAlertMessage("Error", message: "Password cannot be empty")
            return false
        }
        
        return true
    }
    
    
    
    @IBAction func signupClicked(sender: AnyObject) {
        
        if(!checkValidInputFields()) {
            // Ensure the input is valid
            return
        }
        
        // Login through the API manager
        ApiManager.sharedInstance.register(emailTextField.text!, password: passwordTextField.text!)
            .validate()
            .responseString { _, _, result in
                
                switch(result) {
                case .Success:
                    
                    // Successfully registered
                    // Now we need to login to obtain the JWT token
                    self.loginAfterRegister()
                    
                case .Failure(_, let error):
                    
                    // Error while registering
                    print(error)
                    self.showAlertMessage("Cannot register", message: "TODO - Get message for why registration failed")
                }
        }
    }
    
    func loginAfterRegister() {
        
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
                    self.setRootViewController("MainTabBarController")
                    
                case .Failure(_, let error):
                    
                    // Invalid email/password
                    print(error)
                    self.showAlertMessage("Cannot login", message: "Invalid email/password")
                }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch(textField) {
        case emailTextField:
            // Move from Email to Password text field
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            break
            
        case passwordTextField:
            // "Go" button pressed on the password field
            // perform the login
            passwordTextField.resignFirstResponder()
            signupClicked(self)
            break
            
        default:
            break
        }
        
        return true
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Hide the keyboard when touching away from the textfield
        self.view.endEditing(true)
    }
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
}

