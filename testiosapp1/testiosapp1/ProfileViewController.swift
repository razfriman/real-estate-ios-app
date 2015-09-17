//
//  ProfileViewController
//  testiosapp1
//
//  Created by Raz Friman on 9/4/15.
//  Copyright (c) 2015 Raz Friman. All rights reserved.
//

import UIKit
class ProfileViewController: UIViewController {
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let userId = ApiManager.sharedInstance.loadFromKeychain(ApiManager.USER_ID_KEY_NAME) {
            
            ApiManager.sharedInstance.loadUser(userId)
                .validate()
                .responseObject { (_, _, result: Result<User>) in
                    
                    switch(result) {
                    case .Success:
                        
                        if let user = result.value {
                            self.user = user
                            self.emailLabel.text = user.email
                            self.nameLabel.text = "\(user.firstName) \(user.lastName)"
                            
                        }
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

