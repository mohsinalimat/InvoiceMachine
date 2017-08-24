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
        static let loginScreenSegueIdentifier = "LoginScreen"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener  { [weak self] (auth, user)  in
            if let user = user {
                // TODO: User is signed in.
            } else {
                self?.performSegue(withIdentifier: Storyboard.loginScreenSegueIdentifier, sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
