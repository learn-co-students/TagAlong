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
    var matchChannel = [Match]()
    
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
            
            self.createMatchChannel()
//        })
        
    }
    
    func createMatchChannel() {
        
        let newMatchRef = matchRef.childByAutoId()
        
        let messageRef = newMatchRef.child("Messages")
        
        print(messageRef)
        
        let convo = ["name" : "Jim"]
        
        messageRef.setValue(convo, withCompletionBlock: { error, ref in
            
            print("We're success")
            
            
            
        })
        
        //let uniqueMessageID = UUID().uuidString
        
//        let convo = [uniqueMessageID : ["name" : "Jim", "message": "YOLO!!!", "Time" : "10000"]]
        
        
        
     //   messageRef.updateChildValues(convo)
        
    }
    
//    
//    deinit {
//        if let refHandle = matchRefHandle {
//            matchRef.removeObserver(withHandle: refHandle)
//        }
//    }
    
    // MARK: Firebase related methods
    
    //You call observe:with: on your channel reference, storing a handle to the reference. This calls the completion block every time a new channel is added to your database.
    //The completion receives a FIRDataSnapshot (stored in snapshot), which contains the data and other helpful methods.
    //You pull the data out of the snapshot and, if successful, create a Channel model and add it to your channels array.
//    private func observeChannels() {
//        // Use the observe method to listen for new
//        // channels being written to the Firebase DB
//        matchRefHandle = matchRef.observe(.childAdded, with: { (snapshot) -> Void in // 1
//            let channelData = snapshot.value as! [String : AnyObject] // 2
//            let id = snapshot.key
//            if let name = channelData["name"] as! String!, name.characters.count > 0 { // 3
//                self.matchChannel.append(Match(id: id, name: name))
//            } else {
//                print("Error! Could not decode channel data")
//            }
//        })
//    }

    
}
