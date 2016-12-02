//
//  FirebaseManager.swift
//  FlatironMasterpiece
//
//  Created by Joyce Matos on 12/1/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit


final class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    let ref = FIRDatabase.database().reference().root
    
    
    private init() {}
    
    //this function is called in AccountCreationViewController, createAccountButton()
    func create(currentUser: User, completion: @escaping (Bool) -> Void) {
        // 1 - create a new user in Firebase
        FIRAuth.auth()?.createUser(withEmail: currentUser.emailAddress, password: currentUser.passWord, completion: { (user, error) in
            
            guard error == nil, let rawUser = user else { completion(false); return }
            //2 - save the new user in Firebase
            self.ref.child("users").child(rawUser.uid).setValue(currentUser.serialize(), withCompletionBlock: { error, ref in
                
                guard error == nil else { completion(false); return }
                
                completion(true)
                
            })
        })
    }
    
    func sendEmailVerification() {
        
        FIRAuth.auth()?.currentUser?.sendEmailVerification(completion: { (error) in
            if error == nil {
                print("Email sent")
            }
            else {
                print(error?.localizedDescription)
            }
        })
    }
    
    func listenForLogIn() {
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                // Move to next screen
                // Add logout button to user's settings screen
            } else {
                // No user is signed in.
                // Display log in screen
                // createViews()
            }
        }
 
    }
    
    func loginToFirebase(email: String, password: String, completion: @escaping (Bool)-> Void) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            guard error == nil else { completion(false); return }
            
            completion(true)
        })
    }
    
    func sendPasswordReset(email: String, completion: @escaping (Bool) -> Void) {
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            guard error == nil else { completion(false); return }
                        
            completion(true)
        })

        
    }
    
    func facebookLogIn() {
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        print("credential is \(credential)")
        
        if let token = FBSDKAccessToken.current() {
            print("ALL good")
            if let tokenString = token.tokenString {
                if let token = FBSDKAccessToken.current() {
                    print("ALL good")
                    if let tokenString = token.tokenString {
                        print("Token string is here \(tokenString)")
                    }
                    
                }
            }
            
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                
                print("User has logged into Firebase")
                
                // TODO: - Segue into home screen after user has logged in
                // Send to preferences (for now)
                let preferencesVC = PreferenceViewController()
                self.navigationController?.pushViewController(preferencesVC, animated: true)
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
            print("User has logged in")
            print("=====================================================\n\n\n")
            
        }

        
        
    }
    
    
    
    func createChatData(completion: (Bool) -> Void) {
        
        
        
    }
    
    
    
    

}
