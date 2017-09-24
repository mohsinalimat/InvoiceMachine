//
//  CompanyInfoViewController.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/21/17.
//  Copyright © 2017 njen. All rights reserved.
//

import UIKit
import Eureka
import Firebase


class CompanyInfoViewController: FormViewController {
    
    var company: Company?
    lazy var ref: DatabaseReference = Database.database().reference()
    
    fileprivate struct RowTags {
        static let CompanyName = "Company name"
        static let Street = "Street"
        static let Street2 = "Street 2"
        static let PostCode = "Postal/Zip Code"
        static let City = "City"
        static let State = "Province/State"
        static let Phone = "Phone"
        static let Fax = "Fax"
        static let Email = "Email"
        static let Website = "Website"
        static let ABN = "ABN"
        static let ACN = "ACN"
        static let Other = "Other"

    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        let validationError =  self.form.validate()
        if(validationError.count  == 0){
            self.company = self.company ?? Company()
            self.company?.name = getTextFromRow(RowTags.CompanyName)
            self.company?.email = getEmailFromRow(RowTags.Email)
            self.company?.phone = getPhoneFromRow(RowTags.Phone)
            self.company?.street = getTextFromRow(RowTags.Street)
            self.company?.street2 = getTextFromRow(RowTags.Street2)
            self.company?.postCode = getZipCodeFromRow(RowTags.PostCode)
            self.company?.city = getTextFromRow(RowTags.City)
            self.company?.state = getTextFromRow(RowTags.State)
            self.company?.fax = getPhoneFromRow(RowTags.Fax)
            self.company?.abn = getTextFromRow(RowTags.ABN)
            self.company?.acn = getTextFromRow(RowTags.ACN)
            self.company?.other = getTextFromRow(RowTags.Other)
            self.company?.website = getUrlFromRow(RowTags.Website)
            let userID = Auth.auth().currentUser?.uid
            // Create new post at /user-clients/$userid/$clientId and at
            // [START write_fan_out]
            let key = company?.id ?? ref.child(FirebaseTableName.userCompanyTableName).childByAutoId().key
            self.company?.id = key
            
            let companyUpdate = ["uid": userID,
                                CompanyTablePropertyName.name: company?.name,
                                CompanyTablePropertyName.email: company?.email,
                                CompanyTablePropertyName.phone: company?.phone,
                                CompanyTablePropertyName.street: company?.street,
                                CompanyTablePropertyName.street2: company?.street2,
                                CompanyTablePropertyName.postCode: company?.postCode,
                                CompanyTablePropertyName.city: company?.city,
                                CompanyTablePropertyName.state: company?.state]
            let childUpdates = ["/\(FirebaseTableName.userCompanyTableName)/\(userID ?? "")/\(key)/": companyUpdate]
            ref.updateChildValues(childUpdates)
            // [END write_fan_out]
            self.dismiss(animated: true) {
                print("done")
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeForm()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initializeForm() {
        EmailRow.defaultCellUpdate = {cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        URLRow.defaultCellUpdate = {cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        
        
        form +++
            
            NameRow(RowTags.CompanyName) {
                $0.placeholder = $0.tag
            }
            
            +++ Section("IDENTIFICATION")
            
            <<< TextRow(RowTags.ABN) {
                $0.title = $0.tag
            }.cellSetup { cell, _  in
                    cell.textField.keyboardType = .numberPad
            }
            <<< TextRow(RowTags.ACN) {
                $0.title = $0.tag
            }.cellSetup { cell, _  in
                    cell.textField.keyboardType = .numberPad
            }
            <<< TextRow(RowTags.Other) {
                $0.title = $0.tag
            }
            
            +++ Section("ADDRESS")
            
            <<< NameRow(RowTags.Street).cellSetup { cell, row in
                row.title = row.tag
            }
            <<< NameRow(RowTags.Street2).cellSetup { cell, row in
                row.title = row.tag
            }
            <<< ZipCodeRow(RowTags.PostCode).cellSetup { cell, row in
                row.title = row.tag
            }
            <<< NameRow(RowTags.City).cellSetup { cell, row in
                row.title = row.tag
            }
            <<< NameRow(RowTags.State).cellSetup { cell, row in
                row.title = row.tag
            
            }
            
            +++ Section("CONTACT DETAILS")
            
            <<< PhoneRow(RowTags.Phone).cellSetup { cell, row in
                row.title = row.tag
            }
            <<< PhoneRow(RowTags.Fax).cellSetup { cell, row in
                row.title = row.tag
            }
            <<< EmailRow(RowTags.Email).cellSetup { cell, row in
                row.title = row.tag
                row.add(rule: RuleEmail())
                row.validationOptions = .validatesOnChangeAfterBlurred
            }
        
            <<< URLRow(RowTags.Website) {
                $0.title = $0.tag
                $0.add(rule: RuleURL())
                $0.validationOptions = .validatesOnChangeAfterBlurred
            }
            
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
