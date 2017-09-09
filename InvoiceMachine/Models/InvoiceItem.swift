//
//  InvoiceItem.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/9/17.
//  Copyright © 2017 njen. All rights reserved.
//

import Foundation

struct InvoiceItem: Equatable {
    
    var id: String
    var description: String
    var amount: Double
    var tax: Double
}

func ==(lhs: InvoiceItem, rhs: InvoiceItem) -> Bool {
    return lhs.id == rhs.id
}
