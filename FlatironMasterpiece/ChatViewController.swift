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
    
    // References
    private var matchRef: FIRDatabaseReference!
    private var messageRef: FIRDatabaseReference!
    private var membersRef: FIRDatabaseReference!


    private var matchRefHandle: FIRDatabaseHandle?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRApp.configure()
        
        matchRef = FIRDatabase.database().reference().child("Match")
        messageRef = FIRDatabase.database().reference().child("Message")
        membersRef = FIRDatabase.database().reference().child("Members")
        
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
        //TODO: Set uniqueID's to match
        
        
        // Match branch
        let newMatchRef = matchRef.childByAutoId()
        let message = [
            "name" : senderId,
            "message" : "Hey what's up", // This will be taken from a textfield
        ]
        
        newMatchRef.setValue(message) { (error, ref) in
            print("Match: we have a message in our match")
        }
        
        // Message ref
        let newMessageRef = messageRef.childByAutoId()
        let messageInfo = [
            "user" : senderId,
            "message" : "Hello",     // This will be taken from textfield
            "timestamp" : "8:00"    // This will be the time the chat started
            ]
        
        newMessageRef.setValue(messageInfo, withCompletionBlock: { error, ref in
            print("Message: We have details in our message ")
        })
        
        
        // Members ref
        let newMemberRef = membersRef.childByAutoId()
        let members = [
            "User's unique ID" : true,
            "User 2's unique ID" : true
        ]
        
        newMemberRef.setValue(members) { (error, ref) in
            print("Members: We have member info for our members")
        }
        
        

    }
    
}
