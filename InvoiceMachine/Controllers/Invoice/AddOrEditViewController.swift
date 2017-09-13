//
//  AddOrEditViewController.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/6/17.
//  Copyright © 2017 njen. All rights reserved.
//

import UIKit
import Eureka
import Firebase


class AddOrEditViewController: FormViewController {
    
    var ref: DatabaseReference = Database.database().reference()
    var invoiceRef: DatabaseReference!
    var invoiceItemsRef: DatabaseReference!
    var invoiceKey:String?
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true) { 
    
        }
    }
    fileprivate struct Storyboard{
        static let ClientViewControllerSegueIdentifier = "ClientViewControllerSegue"
        static let InvoiceItemViewControllerSegueIdentifier = "InvoiceItemViewControllerSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invoiceKey = invoiceKey ?? ref.child("invoices").childByAutoId().key
        invoiceRef = ref.child("invoices").child(invoiceKey!)
        invoiceItemsRef = ref.child("invoice-items").child(invoiceKey!)
        initializeForm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    
    private func initializeForm() {
        
        form +++
            
            ClientRow("Client") {  row in
                row.presentationMode = .segueName(segueName: Storyboard.ClientViewControllerSegueIdentifier, onDismiss:{  vc in
                    let clientViewController = vc as! ClientViewController
                    row.value = clientViewController.client
                    row.updateCell()
                    vc.navigationController?.popViewController(animated: true)
                
                })
            
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
                                $0.tag = "InvoiceSection"
                                $0.addButtonProvider = { section in
                                    return ButtonRow(){
                                        $0.title = "Add New Item"
                                        }.cellUpdate { cell, row in
                                            cell.textLabel?.textAlignment = .left
                                    }
                                }
                                $0.multivaluedRowToInsertAt = { index in
                                    return InvoiceItemRow() {
                                       $0.value = InvoiceItem(id: "\(index)", description: "Item \(index)", amount: 0.0, tax: 0.0)
                                        $0.tag = "Invoice Item at \(index)"
                                       $0.presentationMode = .segueName(segueName: Storyboard.InvoiceItemViewControllerSegueIdentifier, onDismiss:{  vc in vc.dismiss(animated: true) })

                                        
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier! {
        case Storyboard.ClientViewControllerSegueIdentifier:
            let row = sender as! ClientRow
            let clientViewController =  segue.destination as! ClientViewController
            clientViewController.client = row.value
            clientViewController.onDismissCallback =  row.presentationMode?.onDismissCallback
        case Storyboard.ClientViewControllerSegueIdentifier:
            break
        default:
            break
        }

    }
    
}

