//
//  ClientViewController.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/9/17.
//  Copyright © 2017 njen. All rights reserved.
//

import UIKit
import Eureka

class ClientViewController: FormViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         initializeForm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    
    private func initializeForm() {
        
        TextRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        form +++
            
            TextRow("Name").cellSetup { cell, row in
                row.title = row.tag
                cell.textField.placeholder = "Required"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
            }
            <<< TextRow("Email").cellSetup { cell, row in
                row.title = row.tag
                row.add(rule: RuleEmail())
                row.validationOptions = .validatesOnChangeAfterBlurred
            }
            +++ Section("Address")
        
            <<< TextRow("Street").cellSetup { cell, row in
                row.placeholder = row.tag
            }
            <<< TextRow("Street 2").cellSetup { cell, row in
                row.placeholder = row.tag
            }
            <<< TextRow("Postal/Zip Code").cellSetup { cell, row in
                row.placeholder = row.tag
            }
            <<< TextRow("City").cellSetup { cell, row in
                row.placeholder = row.tag
            }
            <<< TextRow("Province/State").cellSetup { cell, row in
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

}
