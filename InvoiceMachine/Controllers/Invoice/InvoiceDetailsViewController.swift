//
//  InvoiceDetails.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/20/17.
//  Copyright © 2017 njen. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class InvoiceDetailsViewController:FormViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initializeForm()
    }
    private func initializeForm() {
        
        form +++
            
            ClientRow("Client") {  row in
                row.presentationMode = .segueName(segueName: "fd", onDismiss:{  vc in
                    let clientViewController = vc as! ClientViewController
                    row.value = clientViewController.client
                    row.updateCell()
                    vc.navigationController?.popViewController(animated: true)
                    
                })
                
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

