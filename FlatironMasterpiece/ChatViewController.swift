//
//  ChatViewController.swift
//  FlatironMasterpiece
//
//  Created by Joyce Matos on 11/21/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import JSQMessagesViewController


class ChatViewController: JSQMessagesViewController {
    
    // Stores user's name and match
    var userName: String?
//    var matchChannel = [Match]()
    
    //
    //var ref = FIRDatabase.database().reference().root
    
    // Creates reference to match channel
    private var matchRef: FIRDatabaseReference!
    private var matchRefHandle: FIRDatabaseHandle?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRApp.configure()
        
        matchRef = FIRDatabase.database().reference().child("Match")
        
//        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
        
        self.senderId = "JOHN"
        self.senderDisplayName = "BLHA"
        
            
            //Sets the senderId based on the logged in Firebase user.
           // self.senderId = FIRAuth.auth()?.currentUser?.uid
           // self.senderDisplayName = FIRAuth.auth()?.currentUser?.uid
            
            self.setupChatDatabase()
//        })
        
    }
    
    func setupChatDatabase() {
        
        // Match branch
        
        let newMatchRef = matchRef.childByAutoId()
        let messageRef = newMatchRef.child("Messages")
        
        print(messageRef)
        
        let convo = [
            "name" : senderId,
            "message" : "Hello",     // This will be taken from textfield
            "timestamp" : "8:00"    // This will be the time the chat started
            ]
        
        messageRef.setValue(convo, withCompletionBlock: { error, ref in
            
            print("We're success")
            
            
            
        })
        

    }
    
}
