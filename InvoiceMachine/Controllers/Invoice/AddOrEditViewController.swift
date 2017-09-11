//
//  AddOrEditViewController.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/6/17.
//  Copyright © 2017 njen. All rights reserved.
//

import UIKit
import Eureka

class AddOrEditViewController: FormViewController {
    

    fileprivate struct Storyboard{
        static let ClientViewControllerSegueIdentifier = "ClientViewControllerSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeForm()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    private func initializeForm() {
        
        form +++
            
            ButtonRow("Client") { row in
                row.title = row.tag
                row.presentationMode = .segueName(segueName: Storyboard.ClientViewControllerSegueIdentifier, onDismiss:{  vc in vc.dismiss(animated: true) })
            }
            
            +++
            
            ButtonRow("Details") { row in
                row.title = row.tag
                row.presentationMode = .segueName(segueName: "NativeEventsFormNavigationControllerSegue", onDismiss:{  vc in vc.dismiss(animated: true) })
            }
            
            +++
            
            MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                               header: "Items",
                               footer: ".Please click on 'Add New Item' button to add new item.") {
                                $0.addButtonProvider = { section in
                                    return ButtonRow(){
                                        $0.title = "Add New Item"
                                        }.cellUpdate { cell, row in
                                            cell.textLabel?.textAlignment = .left
                                    }
                                }
                                $0.multivaluedRowToInsertAt = { index in
                                    return InvoiceItemRow() {
                                       $0.value = InvoiceItem(id: "", description: "Testing description", amount: 12.5, tax: 30.1)
                                       $0.presentationMode = .segueName(segueName: "NativeEventsFormNavigationControllerSegue", onDismiss:{  vc in vc.dismiss(animated: true) })

                                        
                                    }
                                }
            }
            
            +++
            LabelRow () {
                $0.title = "Subtotal"
                $0.value = "$12.5"
                
            }
            
            <<< LabelRow(){
                $0.title = "GST"
                $0.value = "$12.5"
                
            }
            <<<  LabelRow () {
                $0.title = "Total"
                $0.value = "$12.5"
                
            }
            
            +++
            
            ButtonRow("Preview") { row in
                row.title = row.tag
                row.presentationMode = .segueName(segueName: "NativeEventsFormNavigationControllerSegue", onDismiss:{  vc in vc.dismiss(animated: true) })
        }
        
    }
    
}

