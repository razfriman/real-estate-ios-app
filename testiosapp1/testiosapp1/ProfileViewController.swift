//
//  ProfileViewController
//  testiosapp1
//
//  Created by Raz Friman on 9/4/15.
//  Copyright (c) 2015 Raz Friman. All rights reserved.
//

import UIKit
class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let userId = ApiManager.sharedInstance.loadFromKeychain(ApiManager.USER_ID_KEY_NAME) {
            
            ApiManager.sharedInstance.loadUser(userId)
                .validate()
                .responseJSON { _, _, result in
                    
                    switch(result) {
                    case .Success:
                        
                        let json = result.value as? NSDictionary // info will be nil if it's not an NSDictionary
                        let email = json?["email"] as? String
                        let id = json?["_id"] as? String
                        
                        self.emailLabel.text = email
                        self.nameLabel.text = id
                        
                        print(result)
                        debugPrint(result)
                        
                    case .Failure(_, let error):
                        print(error)
                        self.showAlertMessage("ERROR", message: "Cannot Load User")
                    }
            }
        }
    }
    
    @IBAction func logoutClicked(sender: AnyObject) {
        
        // Clear the login token
        ApiManager.sharedInstance.clearFromKeychain(ApiManager.JWT_TOKEN_KEY_NAME)
        ApiManager.sharedInstance.clearFromKeychain(ApiManager.USER_ID_KEY_NAME)
        ApiManager.sharedInstance.clearFromKeychain(ApiManager.EMAIL_KEY_NAME)
        
        // Return to the login screen
        self.setRootViewController("LoginViewController")
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
}

