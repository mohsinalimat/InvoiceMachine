//
//  Constants.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/18/17.
//  Copyright © 2017 njen. All rights reserved.
//

import Foundation

struct FirebaseTableName {
    static let userClientTableName = "user-clients"
    static let userTableName = "users"
    static let userInvoiceTableName = "user-invoices"
    static let userCompanyTableName = "user-company"
    static let invoiceItemTableName = "invoice-items"
}

struct UserTablePropertyName {
    static let displayName = "displayName"
    static let photoURL = "photoURL"
    static let email = "email"
}

struct ClientTablePropertyName {
    static let name = "name"
    static let email = "email"
    static let phone = "phone"
    static let street = "street"
    static let street2 = "street2"
    static let postCode = "postCode"
    static let city = "city"
    static let state = "state"
}
struct CompanyTablePropertyName {
    static let name = "name"
    static let abn = "abn"
    static let acn = "acn"
    static let other = "other"
    static let street = "street"
    static let street2 = "street2"
    static let postCode = "postCode"
    static let city = "city"
    static let state = "state"
    static let phone = "phone"
    static let fax = "fax"
    static let email = "email"
    static let website = "website"
}
