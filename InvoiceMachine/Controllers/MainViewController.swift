//
//  MainViewController.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 8/24/17.
//  Copyright © 2017 njen. All rights reserved.
//

import UIKit
import Firebase


class MainViewController: UITabBarController {
    
    
    fileprivate struct Storyboard{
        static let loginSegueIdentifier = "Login"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener  { [weak self] (auth, user)  in
            if let user = user {
                // TODO: User is signed in.
            } else {
                self?.performSegue(withIdentifier: Storyboard.loginSegueIdentifier, sender: nil)
            }
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
