//
//  FirebaseManager.swift
//  FlatironMasterpiece
//
//  Created by Joyce Matos on 12/1/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation
import Firebase


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
    
    
    func createChatData(completion: (Bool) -> Void) {
        
        
        
    }
    
    
    
    

}
