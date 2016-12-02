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
    
    
    func create(currentUser: User, completion: @escaping (Bool) -> Void) {
        
        FIRAuth.auth()?.createUser(withEmail: currentUser.emailAddress, password: currentUser.passWord, completion: { (user, error) in
            
            guard error == nil, let rawUser = user else { completion(false); return }
            
            self.ref.child("users").child(rawUser.uid).setValue(currentUser.serialize(), withCompletionBlock: { error, ref in
                
                guard error == nil else { completion(false); return }
                
                completion(true)
                
            })
        })
    }
    
    
    func createChatData(completion: (Bool) -> Void) {
        
        
        
    }
    
    
    
    

}
