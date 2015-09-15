//
//  Extensions.swift
//  testiosapp1
//
//  Created by Raz Friman on 9/14/15.
//  Copyright (c) 2015 Raz Friman. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Show an alert message
    func showAlertMessage(title: String, message: String, actionTitle: String="Dismiss", handler: ((UIAlertAction) -> Void)?=nil) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default,handler: handler))
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // Validate an email address
    func validateEmail(email: String?) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluateWithObject(email)
    }
}