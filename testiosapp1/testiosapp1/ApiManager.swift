//
//  RestApiManager.swift
//  testiosapp1
//
//  Created by Raz Friman on 9/14/15.
//  Copyright (c) 2015 Raz Friman. All rights reserved.
//

import Foundation

class ApiManager: NSObject {

    // Singleton instance of the ApiManager
    static let sharedInstance = ApiManager()
    
    // Constants
    let BASE_URL = "https://nodetest999.herokuapp.com/api"
    let JWT_TOKEN_KEYCHAIN = "com.myrealestate"
    let JWT_TOKEN_KEY_NAME = "jwtToken"

    
    
    func login(email: String, password: String) -> Request {
        let parameters : [String:AnyObject] = [
            "email": email,
            "password": password
            ]
        
            let apiRequest = request(.POST, "\(BASE_URL)/login", parameters: parameters, encoding: .JSON)

        return apiRequest
    }
    
    func register(email: String, password: String) -> Request {
        let parameters : [String:AnyObject] = [
            "email": email,
            "password": password
        ]
        
        let apiRequest = request(.POST, "\(BASE_URL)/register", parameters: parameters, encoding: .JSON)
        
        return apiRequest
    }
    
    
    func saveToKeychain(jwtToken: String) {
        let keychain = Keychain(service: JWT_TOKEN_KEYCHAIN)
        keychain[JWT_TOKEN_KEY_NAME] = jwtToken
    }
    
    func loadToken() -> String? {
        let keychain = Keychain(service: JWT_TOKEN_KEYCHAIN)
        let token = keychain[JWT_TOKEN_KEY_NAME]
        return token
    }
    
    func clearTokenFromKeychain() {
        let keychain = Keychain(service: JWT_TOKEN_KEYCHAIN)
        keychain[JWT_TOKEN_KEY_NAME] = nil
    }
}