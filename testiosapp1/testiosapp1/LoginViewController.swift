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
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginClicked(sender: AnyObject) {
        // TODO - Login here
        
        
        let parameters = [
            "email": emailTextField.text!,
            "password": passwordTextField.text!
        ]
        
        request(.POST, "https://nodetest999.herokuapp.com/api/login", parameters: parameters, encoding: .JSON)
            .validate()
            .responseString { _, _, result in
                
                switch(result) {
                case .Success:
                    print("Validation Successful")
                    debugPrint(result)
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                case .Failure(_, let error):
                    print(error)
                }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if(textField == emailTextField) {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            return true
        } else if (textField == passwordTextField) {
            passwordTextField.resignFirstResponder()
            loginClicked(self)
            return true
        } else {
            return false
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func unwindToLoginScreen(segue: UIStoryboardSegue) {
        
    }
}

