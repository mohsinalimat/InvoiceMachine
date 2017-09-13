//
//  Client.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/13/17.
//  Copyright © 2017 njen. All rights reserved.
//

import Foundation

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
}

func ==(lhs: Client, rhs: Client) -> Bool {
    return lhs.id == rhs.id
}
