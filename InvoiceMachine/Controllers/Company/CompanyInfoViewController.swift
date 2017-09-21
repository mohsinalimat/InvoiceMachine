//
//  CompanyInfoViewController.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/21/17.
//  Copyright © 2017 njen. All rights reserved.
//

import UIKit
import Eureka


class CompanyInfoViewController: FormViewController {
    
    fileprivate struct RowTags {
        static let InvoiceNumber = "Invoice number"
        static let IssueDate = "Issue date"
        static let DueDate = "Due date"
        static let Reference = "Reference"
        static let Introduction = "Introduction/Salutatioin"
        static let Note = "Note"
        static let Company = "Your company"
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            print("done")
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
        
        form +++
            
            TextRow(RowTags.InvoiceNumber) {
                $0.title = $0.tag
                }.cellSetup { cell, _  in
                    cell.textField.keyboardType = .numbersAndPunctuation
            }
            <<< DateRow(RowTags.IssueDate){
                $0.title = $0.tag
                $0.value = Date()
                let formatter = DateFormatter()
                formatter.locale = .current
                formatter.dateStyle = .medium
                $0.dateFormatter = formatter
            }
            <<< DateRow(RowTags.DueDate){
                $0.title = $0.tag
                $0.value = Date()
                let formatter = DateFormatter()
                formatter.locale = .current
                formatter.dateStyle = .medium
                $0.dateFormatter = formatter
            }
            
            +++
            
            TextRow(RowTags.Reference) {
                $0.title = $0.tag
                
                }.cellSetup { cell, _  in
                    cell.textField.keyboardType = .numberPad
            }
            
            +++
            
            TextRow(RowTags.Introduction) {
                $0.placeholder = $0.tag
                
            }
            <<< TextRow(RowTags.Note) {
                $0.placeholder = $0.tag
                
            }
            +++
            
            ButtonRow(RowTags.Company) {  row in
                row.title = row.tag
                row.presentationMode = .segueName(segueName: "", onDismiss:{  vc in
                    row.updateCell()
                    vc.navigationController?.popViewController(animated: true)
                    
                })
                
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
