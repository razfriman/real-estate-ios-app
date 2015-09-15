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
        
        ApiManager.sharedInstance.loadUser(ApiManager.sharedInstance.loadFromKeychain(ApiManager.USER_ID_KEY_NAME)!)
            .validate()
            .responseJSON { _, _, result in
                
                switch(result) {
                case .Success:
                    
                    let json = result.value as? NSDictionary // info will be nil if it's not an NSDictionary
                    
                    print(result)
                    debugPrint(result)
                    self.showAlertMessage("SUCCESS", message: "Loaded User")
                    
                case .Failure(_, let error):
                    print(error)
                    self.showAlertMessage("ERROR", message: "Cannot Load User")
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutClicked(sender: AnyObject) {

        // Clear the login token
        ApiManager.sharedInstance.clearFromKeychain(ApiManager.JWT_TOKEN_KEY_NAME)
        ApiManager.sharedInstance.clearFromKeychain(ApiManager.USER_ID_KEY_NAME)
        ApiManager.sharedInstance.clearFromKeychain(ApiManager.EMAIL_KEY_NAME)

        // Return to the login screen
        performSegueWithIdentifier("logoutSegue", sender: self)
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
}

