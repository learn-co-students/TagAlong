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
    
    let store = FirebaseManager.shared
    
    var username: String?
    var messages = [JSQMessage]()
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
//    // Reference properties
    
    //1 - create a "chat" entity in firebase
    let allChatsRef = FIRDatabase.database().reference().child("chats")
    
    //2 - creating a tagalongID
        var chatRef: FIRDatabaseReference!
    
    //3 - creates an observation of our tagalongID attributes
    private var newMessageRefHandle: FIRDatabaseHandle?
    
    //4 - prop that represents the tagalong id
    var chatID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let chatID = chatID {
        chatRef = allChatsRef.child("\(chatID)")
        }
        
        // Testing on a real user
        self.senderId = FIRAuth.auth()?.currentUser?.email
//        self.senderId = store.currentUser
        
        
        //TODO: - change this displayName to the currentUser's name
        self.senderDisplayName = FIRAuth.auth()?.currentUser?.email
        
        
        // Removing avatars
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        observeMessages()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Dummy Data
        
        //        // messages from someone else
        //        addMessage(withId: "foo", name: "Mr.Bolt", text: "I am so fast!")
        //        // messages sent from local sender
        //        addMessage(withId: senderId, name: "Me", text: "I bet I can run faster than you!")
        //        addMessage(withId: senderId, name: "Me", text: "I like to run!")
        //        // animates the receiving of a new message on the view
        //        finishReceivingMessage()
    }
    
    
    // Creates messages ref and saves a message to Firebase
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        //TODO: Set UID for the 'messages' branch to match 'match' and 'members' branch, and keep the UID for each individual message seperate from the main branches ('messages', 'match', 'members').
        
        let messageItem = [ // 2
            "senderId": senderId!,
            "senderName": senderDisplayName!,
            "text": text!,
            "timestamp": String(Int(Date().timeIntervalSince1970))
        ]
        
        self.chatRef.updateChildValues(["\(messages.count)": messageItem])
        
        //        itemRef.setValue(messageItem) // 3 - This can be done with closure to check for error
        
        // message sent sound
        JSQSystemSoundPlayer.jsq_playMessageSentSound() // 4
        
        // animates sending of message
        finishSendingMessage() // 5
        
        
        // Reset the typing indicator when the Send button is pressed.
        //        isTyping = false
        
    }
    
    deinit {
        if let refHandle = newMessageRefHandle {
            chatRef.removeObserver(withHandle: refHandle)
        }
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
    // If the message was sent by current user, return the outgoing image view.
    // Otherwise, return the incoming image view.
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }
    
    // Does not display avatar
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
    
    
    // Observe Messages
    private func observeMessages() {
        
        // 1. Creating a query that limits the synchronization to the last 25 messages
        //        let messageQuery = chatRef.queryLimited(toLast:25)
        
        // 2. Observe every child item that has been added, and will be added, at the messages location.
        newMessageRefHandle = chatRef.observe(.childAdded, with: { (snapshot) -> Void in
            
            print("--------------------GETTING CALLED------------------")
            
            // 3. Extract the messageData from the snapshot
            
            print("messageQuery snapshot: \(snapshot.value)")
            let messageData = snapshot.value as! [String: Any]
            
            if let id = messageData["senderId"] as! String!,
                let name = messageData["senderName"] as! String!,
                let text = messageData["text"] as! String!,
                text.characters.count > 0 {
                
                // 4. Add the new message to the data source
                self.addMessage(withId: id, name: name, text: text)
                
                // 5. Inform JSQMessagesViewController that a message has been received.
                self.finishReceivingMessage()
            } else {
                print("Error! Could not decode message data")
            }
            
            print("----------------------------------------------\n\n\n")
        })
    }
    
}
