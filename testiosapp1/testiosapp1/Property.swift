//
//  Property.swift
//  MyRealEstate
//
//  Created by Raz Friman on 9/16/15.
//  Copyright © 2015 Raz Friman. All rights reserved.
//

import Foundation

final class Property: ResponseObjectSerializable, ResponseCollectionSerializable {
    let title: String?
    let address: String
    let city: String
    let value: Int
    let totalRentPaid: Int
    let monthsPaid: Int
    let rentPayment: Int
    let returnOnInvestment: Int
    let image: String
    let dateLastPaid: String
    let tenant: Tenant?
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.title = representation.valueForKeyPath("title") as! String?
        self.address = representation.valueForKeyPath("address") as! String
        self.city = representation.valueForKeyPath("city") as! String
        self.value = representation.valueForKeyPath("value") as! Int
        self.totalRentPaid = representation.valueForKeyPath("totalRentPaid") as! Int
        self.monthsPaid = representation.valueForKeyPath("monthsPaid") as! Int
        self.rentPayment = representation.valueForKeyPath("rentPayment") as! Int
        self.returnOnInvestment = representation.valueForKeyPath("returnOnInvestment") as! Int
        self.image = representation.valueForKeyPath("image") as! String
        self.dateLastPaid = representation.valueForKeyPath("dateLastPaid") as! String
        
        let tenantArrayData = representation.valueForKeyPath("tenant") as! NSArray
        let tenantData = tenantArrayData[0]
        self.tenant = Tenant(response: response, representation: tenantData)
        
    }
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Property] {
        var items: [Property] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for itemRep in representation {
                if let item = Property(response: response, representation: itemRep) {
                    items.append(item)
                }
            }
        }
        
        return items
    }
    
    
    func toDictionary() -> NSDictionary {
        let dict : NSDictionary = NSDictionary()
        dict.setValue(title, forKey: "title")
        dict.setValue(address, forKey: "address")
        dict.setValue(image, forKey: "image")
        dict.setValue(city, forKey: "city")
        dict.setValue(value, forKey: "value")
        dict.setValue(totalRentPaid, forKey: "totalRentPaid")
        dict.setValue(monthsPaid, forKey: "monthsPaid")
        dict.setValue(rentPayment, forKey: "rentPayment")
        dict.setValue(returnOnInvestment, forKey: "returnOnInvestment")
        dict.setValue(dateLastPaid, forKey: "dateLastPaid")
        dict.setValue(tenant?.toDictionary(), forKey: "value")
        return dict
    }
}