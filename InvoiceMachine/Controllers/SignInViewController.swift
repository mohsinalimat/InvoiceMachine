//
//  SignInViewController.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 8/22/17.
//  Copyright © 2017 njen. All rights reserved.
//

import UIKit
// [START usermanagement_view_import]
import Firebase
// [END usermanagement_view_import]
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

@objc(SignInViewController)
class SignInViewController: UIViewController, GIDSignInUIDelegate {
    
    lazy var ref: DatabaseReference = Database.database().reference()

    fileprivate struct Storyboard{
        static let mainScreenSegueIdentifier = "MainScreen"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInWithGoogle(_ sender: Any) {
        // [START setup_gid_uidelegate]
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        // [END setup_gid_uidelegate]
    }
    
    @IBAction func signInWithFacebook(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email"], from: self, handler: { (result, error) in
            if let error = error {
                self.showMessagePrompt(error.localizedDescription)
            } else if result!.isCancelled {
                print("FBLogin cancelled")
            } else {
                // [START headless_facebook_auth]
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                // [END headless_facebook_auth]
                self.firebaseLogin(credential)
            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func saveUserInfo(_ user: Firebase.User, withEmail email: String, withDisplayName displayName: String, withPhotoURL photoURL: String) {
        
        // Create a change request
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        changeRequest?.photoURL = URL(string: photoURL)
        
        // Commit profile changes to server
        changeRequest?.commitChanges() { (error) in
            
            LoadingIndicator.hide()
            
            if let error = error {
                self.showMessagePrompt(error.localizedDescription)
                return
            }
            
            // [START basic_write]
            self.ref.child("users").child(user.uid).setValue(["displayName": displayName, "photoURL": photoURL, "email": email])
            // [END basic_write]
            self.performSegue(withIdentifier: Storyboard.mainScreenSegueIdentifier, sender: nil)

        }
        
    }
    
    
    func firebaseLogin(_ credential: AuthCredential) {
        LoadingIndicator.show()
        if let user = Auth.auth().currentUser {
            // [START link_credential]
            user.link(with: credential) { [weak self] (user, error) in
                // [START_EXCLUDE]
                LoadingIndicator.hide()
                if let error = error {
                    self?.showMessagePrompt(error.localizedDescription)
                    return
                }
                self?.performSegue(withIdentifier: Storyboard.mainScreenSegueIdentifier, sender: nil)
                // [END_EXCLUDE]
            }
            // [END link_credential]
        } else {
            // [START signin_credential]
            Auth.auth().signIn(with: credential) { [weak self] (user, error) in
                // [START_EXCLUDE silent]
             
                guard let user = user, error == nil, let userInfo = user.providerData.first else {
                    self?.showMessagePrompt(error!.localizedDescription)
                    LoadingIndicator.hide()
                    return
                }
                
                let email = userInfo.email ?? ""
                let displayName = userInfo.displayName ?? ""
                let photoURL = userInfo.photoURL?.absoluteString ?? ""
                self?.saveUserInfo(user,withEmail: email, withDisplayName: displayName, withPhotoURL: photoURL)
            }
            // [END signin_credential]
        }
    }
    
}
