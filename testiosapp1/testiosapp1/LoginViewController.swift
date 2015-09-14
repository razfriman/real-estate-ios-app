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
            "email": "user@user.com",
            "password": "password"
        ]
        
        
//        request(.GET, "https://nodetest999.herokuapp.com/api").responseJSON { _, _, result in
            //print(result)
          //  debugPrint(result)
        //}
        
        request(.POST, "https://nodetest999.herokuapp.com/api/login", parameters: parameters, encoding: .JSON)
            .responseString { _, _, result in
                
                print(result)
                debugPrint(result)
                
                // Success???
                self.performSegueWithIdentifier("loginSegue", sender: self)
                
                
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

