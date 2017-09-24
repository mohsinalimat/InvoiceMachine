//
//  FormViewController+Extension.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/25/17.
//  Copyright © 2017 njen. All rights reserved.
//

import Foundation
import Eureka
public extension FormViewController {
     func setTextForRow( _ tag: String, _ value: String?){
        let textRow: NameRow = form.rowBy(tag: tag)!
        textRow.value = value
        textRow.updateCell()
    }
    
     func getTextFromRow( _ tag: String) -> String? {
        let textRow: NameRow = form.rowBy(tag: tag)!
        let textEntered = textRow.cell.textField.text
        return textEntered
    }
    
     func setEmailForRow( _ tag:String, _ value: String?) {
        let textRow: EmailRow = form.rowBy(tag: tag)!
        textRow.value = value
        textRow.updateCell()
    }
    
     func getEmailFromRow( _ tag: String) -> String? {
        let textRow: EmailRow = form.rowBy(tag: tag)!
        let textEntered = textRow.cell.textField.text
        return textEntered
    }
    
     func setPhoneForRow( _ tag: String, _ value: String?){
        let textRow: PhoneRow = form.rowBy(tag: tag)!
        textRow.value = value
        textRow.updateCell()
    }
    
     func getPhoneFromRow( _ tag: String) -> String? {
        let textRow: PhoneRow = form.rowBy(tag: tag)!
        let textEntered = textRow.cell.textField.text
        return textEntered
    }
    
     func setZipCodeForRow( _ tag: String, _ value:String?){
        let textRow: ZipCodeRow = form.rowBy(tag: tag)!
        textRow.value = value
        textRow.updateCell()
    }
    
     func getZipCodeFromRow(_ tag: String) -> String? {
        let textRow: ZipCodeRow = form.rowBy(tag: tag)!
        let textEntered = textRow.cell.textField.text
        return textEntered
    }
    func getUrlFromRow(_ tag: String) -> String? {
        let textRow: URLRow = form.rowBy(tag: tag)!
        let textEntered = textRow.cell.textField.text
        return textEntered
    }
}
