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
            SCLAlertView().showError("Invalid email address", subTitle: "")
            return false
        }
        
        if(passwordTextField.text == nil || passwordTextField.text?.characters.count == 0) {
            // Password is required
            SCLAlertView().showError("Password cannot be empty", subTitle: "")
            return false
        }
        
        return true
    }
    
    func setStateForSignupButton(enabled: Bool) {
        self.signupButton.enabled = enabled
        self.signupButton.alpha = enabled ? 1.0 : 0.5
    }
    
    
    
    @IBAction func signupClicked(sender: AnyObject) {
        
        setStateForSignupButton(false)
        
        if(!checkValidInputFields()) {
            // Ensure the input is valid
            setStateForSignupButton(true)
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
                    self.setStateForSignupButton(true)
                    print(error)
                    SCLAlertView().showError("Cannot register", subTitle: "TODO - Get message for why registration failed")
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
                    
                    // Reenable the signup button
                    self.setStateForSignupButton(true)
                    
                    // Perform the segue to move to the main screen of the app
                    self.setRootViewController("MainTabBarController")
                    
                case .Failure(_, let error):
                    
                    // Reenable the signup button
                    self.setStateForSignupButton(true)
                    
                    // Invalid email/password
                    print(error)
                    SCLAlertView().showError("Cannot login", subTitle: "Invalid email/password")
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
    
    @IBOutlet var signupButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
}

