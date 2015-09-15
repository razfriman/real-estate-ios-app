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
    let KEYCHAIN_NAME = "com.myrealestate"
    
    // Static constants
    static let JWT_TOKEN_KEY_NAME = "jwtToken"
    static let USER_ID_KEY_NAME = "userId"
    static let EMAIL_KEY_NAME = "email"
    
    
    
    
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
    
    func checkToken() -> Request {
        let headers = loadAuthHeaders()
        let apiRequest = request(.GET, "\(BASE_URL)/", parameters: nil, encoding: .JSON, headers: headers)
        
        return apiRequest
    }
    
    func loadAuthHeaders() -> [String : String] {
        
        let token = loadFromKeychain(ApiManager.JWT_TOKEN_KEY_NAME) ?? ""
        let headers = ["x-access-token": token]
        return headers
    }
    
    func loadUser(userId: String) -> Request {
        
        let headers = loadAuthHeaders()
        
        let apiRequest = request(.GET, "\(BASE_URL)/users/\(userId)", parameters: nil, encoding: .JSON, headers: headers)
        return apiRequest
    }
    
    func loadUserProperties(userId: String) -> Request {
        let headers = loadAuthHeaders()
        let apiRequest = request(.GET, "\(BASE_URL)/users/\(userId)/properties", parameters: nil, encoding: .JSON, headers: headers)
        
        return apiRequest
    }
    
    
    func saveToKeychain(key: String, value: String) {
        let keychain = Keychain(service: KEYCHAIN_NAME)
        keychain[key] = value
    }
    
    func loadFromKeychain(key: String) -> String? {
        let keychain = Keychain(service: KEYCHAIN_NAME)
        let value = keychain[key]
        return value
    }
    
    func clearFromKeychain(key: String) {
        let keychain = Keychain(service: KEYCHAIN_NAME)
        keychain[key] = nil
    }
}