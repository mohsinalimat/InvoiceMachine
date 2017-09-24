//
//  ClientViewController.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/9/17.
//  Copyright © 2017 njen. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class ClientViewController: FormViewController, RowControllerType {
    
    lazy var ref: DatabaseReference = Database.database().reference()
    var client: Client?
    
    fileprivate struct RowTags {
        static let Name = "Name"
        static let Email = "Email"
        static let Phone = "Phone"
        static let Street = "Street"
        static let Street2 = "Street 2"
        static let PostCode = "Postal/Zip Code"
        static let City = "City"
        static let State = "Province/State"
    }
    
    

    @IBAction func saveTapped(_ sender: Any) {
       let validationError =  self.form.validate()
        if(validationError.count  == 0){
            self.client = self.client ?? Client()
            self.client?.name = getTextFromRow(RowTags.Name)
            self.client?.email = getEmailFromRow(RowTags.Email)
            self.client?.phone = getPhoneFromRow(RowTags.Phone)
            self.client?.street = getTextFromRow(RowTags.Street)
            self.client?.street2 = getTextFromRow(RowTags.Street2)
            self.client?.postCode = getZipCodeFromRow(RowTags.PostCode)
            self.client?.city = getTextFromRow(RowTags.City)
            self.client?.state = getTextFromRow(RowTags.State)
            let userID = Auth.auth().currentUser?.uid

            
            // Create new post at /user-clients/$userid/$clientId and at
            // [START write_fan_out]
            let key = client?.id ?? ref.child("user-clients").childByAutoId().key
            self.client?.id = key
         
            let clientUpdate = ["uid": userID,
                        ClientTablePropertyName.name: client?.name,
                        ClientTablePropertyName.email: client?.email,
                        ClientTablePropertyName.phone: client?.phone,
                        ClientTablePropertyName.street: client?.street,
                        ClientTablePropertyName.street2: client?.street2,
                        ClientTablePropertyName.postCode: client?.postCode,
                        ClientTablePropertyName.city: client?.city,
                        ClientTablePropertyName.state: client?.state]
            let childUpdates = ["/\(FirebaseTableName.userClientTableName)/\(userID ?? "")/\(key)/": clientUpdate]
            ref.updateChildValues(childUpdates)
            self.onDismissCallback?(self)
            // [END write_fan_out]

        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         initializeForm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
        setTextForRow(RowTags.Name, client?.name)
        setEmailForRow(RowTags.Email, client?.email)
        setPhoneForRow(RowTags.Phone, client?.phone)
        setTextForRow(RowTags.Street, client?.street)
        setTextForRow(RowTags.Street2, client?.street2)
        setZipCodeForRow(RowTags.PostCode, client?.postCode)
        setTextForRow(RowTags.City, client?.city)
        setTextForRow(RowTags.State, client?.state)

    }
    
    
    private func initializeForm() {
        
        NameRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        EmailRow.defaultCellUpdate = {cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        form +++
            
            NameRow(RowTags.Name).cellSetup { cell, row in
                row.title = row.tag
                cell.textField.placeholder = "Required"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
            }
            <<< EmailRow(RowTags.Email).cellSetup { cell, row in
                row.title = row.tag
                row.add(rule: RuleEmail())
                row.validationOptions = .validatesOnChangeAfterBlurred
            }
            <<< PhoneRow(RowTags.Phone).cellSetup { cell, row in
                row.title = row.tag
            }
            
            +++ Section("Address")
        
            <<< NameRow(RowTags.Street).cellSetup { cell, row in
                row.placeholder = row.tag
            }
            <<< NameRow(RowTags.Street2).cellSetup { cell, row in
                row.placeholder = row.tag
            }
            <<< ZipCodeRow(RowTags.PostCode).cellSetup { cell, row in
                row.placeholder = row.tag
            }
            <<< NameRow(RowTags.City).cellSetup { cell, row in
                row.placeholder = row.tag
            }
            <<< NameRow(RowTags.State).cellSetup { cell, row in
                row.placeholder = row.tag
            }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    var onDismissCallback: ((UIViewController) -> Void)?

}

