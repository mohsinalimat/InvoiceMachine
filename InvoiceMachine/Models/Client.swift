//
//  Client.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/13/17.
//  Copyright © 2017 njen. All rights reserved.
//

import Foundation
import Firebase
struct Client: Equatable {
    
    var id: String?
    var name: String?
    var email: String?
    var phone: String?
    var street: String?
    var street2: String?
    var postCode: String?
    var city: String?
    var state: String?
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: String] else { return nil }
        
        self.id = snapshot.key
        self.name = dict["name"] ?? ""
        self.email = dict["email"] ?? ""
        self.phone = dict["phone"] ?? ""
        self.street = dict["street"] ?? ""
        self.street2 = dict["street2"] ?? ""
        self.postCode = dict["postCode"] ?? ""
        self.city = dict["city"] ?? ""
        self.state = dict["state"] ?? ""
    }
    
    init( name: String, email: String, phone: String, street: String, street2: String, postCode: String, city: String, state: String){
        self.name = name
        self.email = email
        self.phone = phone
        self.street = street
        self.street2 = street2
        self.postCode = postCode
        self.city = city
        self.state = state
    }
    
    init() {
        self.init(name: "", email: "", phone: "", street: "", street2: "", postCode: "", city: "", state: "")
    }
}




func ==(lhs: Client, rhs: Client) -> Bool {
    return lhs.id == rhs.id
}
