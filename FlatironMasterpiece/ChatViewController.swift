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
    
    var userName: String?
    var messages = [JSQMessage]()
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    // References
    private var matchRef: FIRDatabaseReference!
    private var messageRef: FIRDatabaseReference!
    private var membersRef: FIRDatabaseReference!


    private var matchRefHandle: FIRDatabaseHandle?
    private var newMessageRefHandle: FIRDatabaseHandle?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRApp.configure()
        
        matchRef = FIRDatabase.database().reference().child("Match")
        messageRef = FIRDatabase.database().reference().child("Message")
        membersRef = FIRDatabase.database().reference().child("Members")
        
//        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
        
        self.senderId = "JOHN"
        self.senderDisplayName = "BLHA"
        
        
//        })
        
        self.setupChatDatabase()
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        // messages from someone else
//        addMessage(withId: "foo", name: "Mr.Bolt", text: "I am so fast!")
//        // messages sent from local sender
//        addMessage(withId: senderId, name: "Me", text: "I bet I can run faster than you!")
//        addMessage(withId: senderId, name: "Me", text: "I like to run!")
//        // animates the receiving of a new message on the view
//        finishReceivingMessage()
    }
    
    func setupChatDatabase() {
        //TODO: Set uniqueID's to match
        
        
        // Match branch
        let newMatchRef = matchRef.childByAutoId()
        let message = [
            "name" : senderId,      // This will be the user's username
            "timestamp" : "8:00" // This will be the time the chat started
        ]
        
        newMatchRef.setValue(message) { (error, ref) in
            print("Match: we have a message in our match")
        }
        
        // Message ref
        let newMessageRef = messageRef.childByAutoId()
        let messageInfo = [
            "user" : senderId,
            "message" : "Hello"     // This will be taken from textfield

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
    
    // Make send button save a message to firebase
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let itemRef = messageRef.childByAutoId() // 1
        let messageItem = [ // 2
            "user": senderId!,
            "message": text!,
            ]
        
        itemRef.setValue(messageItem) // 3
        
        
        // message sent sound
        JSQSystemSoundPlayer.jsq_playMessageSentSound() // 4
        
        // animates sending of message
        finishSendingMessage() // 5
        
        
        // Reset the typing indicator when the Send button is pressed.
//        isTyping = false
        
    }
    
    
    
    // MARK: Create Messages/ Create JSQMessage objects and append to array
    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
        }
    }
    
    // MARK: Collection view data source (and related) methods
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    // Here you retrieve the message.
    // If the message was sent by the local user, return the outgoing image view.
    // Otherwise, return the incoming image view.
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    // Change text color for bubble
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView?.textColor = UIColor.white
        } else {
            cell.textView?.textColor = UIColor.black
        }
        return cell
    }

    // MARK: UI and User Interaction
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    
    
    
}
