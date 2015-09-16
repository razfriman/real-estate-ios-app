//
//  User.swift
//  MyRealEstate
//
//  Created by Raz Friman on 9/16/15.
//  Copyright © 2015 Raz Friman. All rights reserved.
//

import Foundation

final class User: ResponseObjectSerializable {
    let email: String
    let firstName: String
    let lastName: String
    let id: String
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.email = representation.valueForKeyPath("email") as! String
        self.id = representation.valueForKeyPath("_id") as! String
        self.firstName = representation.valueForKeyPath("firstName") as! String
        self.lastName = representation.valueForKeyPath("lastName") as! String

    }
}