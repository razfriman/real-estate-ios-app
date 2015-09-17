//
//  ForgotPasswordViewController
//  testiosapp1
//
//  Created by Raz Friman on 9/4/15.
//  Copyright (c) 2015 Raz Friman. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkValidInputFields() -> Bool {
        
        if(!validateEmail(emailTextField.text)) {
            SCLAlertView().showError("Invalid email address", subTitle: "")
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if(textField == emailTextField) {
            // "Go" button pressed on the password field
            // perform the password reset
            emailTextField.resignFirstResponder()
            resetPasswordClicked(self)
        }
        return true
    }
    
    @IBAction func resetPasswordClicked(sender: AnyObject) {
        
        if(!checkValidInputFields()) {
            return
        }
        

        
        // TODO - ADD DISMISS HANDLER
        let alert = SCLAlertView().showSuccess("Password reset", subTitle: "An email to reset your password has been sent to \(emailTextField.text!)")
        alert.setDismissBlock({() -> Void in
        self.performSegueWithIdentifier("forgotPasswordDoneSegue", sender: self)
        })



        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var emailTextField: UITextField!
}

