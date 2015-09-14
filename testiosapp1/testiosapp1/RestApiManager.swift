//
//  RestApiManager.swift
//  testiosapp1
//
//  Created by Raz Friman on 9/14/15.
//  Copyright (c) 2015 Raz Friman. All rights reserved.
//

import Foundation

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    let baseURL = "http://http://nodetest999.herokuapp.com/"
    



    
    func login(email: String, password: String) {
        let data : [String:AnyObject] = [
            "email": "user@user.com",
            "password": "password"
            ]
    }
}