//
//  FirebaseManager.swift
//  FlatironMasterpiece
//
//  Created by Joyce Matos on 12/1/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FBSDKLoginKit


final class FirebaseManager {
    
    static let shared = FirebaseManager()

    // Reference properties
//    let ref = FIRDatabase.database().reference().root
//    var chatRef: FIRDatabaseReference!
//    let allChatsRef = FIRDatabase.database().reference().child("chats")
//    private var newMessageRefHandle: FIRDatabaseHandle?
    var currentUser = FIRAuth.auth()?.currentUser?

    
//    FIRAuth.auth()?.currentUser?.email
    
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
    
    func createTagalong() {
        //1 - create the tagalong branch
        
        //2 - sending the tagalong id to be the child of the chat
    }
    
    func writeToChat(with id:String, chatMessage:String) {
        
        //create a new child under chats
        allChatsRef.child(id).setValue(chatMessage) { (error, ref) in
            //
        }
        
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
    
    func facebookLogIn(completion: @escaping (Bool) -> Void) {
        
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
                
                guard error == nil else { completion(false); return }
                
                completion(true)
                
            
            }
            print("User has logged in")
            print("=====================================================\n\n\n")
            
        }

        
        
    }
    
    
    
    func createChatData(completion: (Bool) -> Void) {
        
        
        
    }
    
    
    
    

}
