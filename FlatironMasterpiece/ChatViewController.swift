//
//  ChatViewController.swift
//  FlatironMasterpiece
//
//  Created by Joyce Matos on 11/21/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import JSQMessagesViewController


class ChatViewController: JSQMessagesViewController {
    
    let store = FirebaseManager.shared
    
    var username: String?
    var messages = [JSQMessage]()
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    var chatID: String?
    
//    var tagalongTag = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("getting loaded")
        self.title = "Chat"
//        navigationController?.isNavigationBarHidden = false
        let block = UIBarButtonItem(title: "Report", style: UIBarButtonItemStyle.plain, target: self, action: "displayBlock")
        navigationItem.rightBarButtonItem = block
       // navigationItem.rightBarButtonItem
        //
        
        //dismisses keyboard
        self.inputToolbar.contentView.leftBarButtonItem = nil
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
//       if let tagAlongID = tagAlongID {
//            tagAlongRef = allChatsRef.child("\(tagAlongID)")
//       }
        
        //Testing FirebaseManager 
//      store.createChatWithTagID()
        
        //Testing on a real user
        self.senderId = FirebaseManager.currentUser

        //TODO: - change this displayName to the currentUser's name
        self.senderDisplayName = FirebaseManager.currentUserEmail
        
        // Removing avatars
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
       // observeMessages()
        guard let tagID = store.selectedTagAlongID else { return }
        
        observeMessages(for: tagID)
        
    }
  
    func displayBlock() {
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    // Creates messages ref and saves a message to Firebase
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        print("\n\nChatViewController\ndidPressSend\nbutton: \(button)\ntext: \(text)\nsenderId: \(senderId)\nsenderDisplayName: \(senderDisplayName)\ndate: \(date)\nself.messages.count: \(self.messages.count)\n\n")
        
        FirebaseManager.sendMessage(senderId: senderId, senderDisplayName: senderDisplayName, text: text, date: date, messageCount: self.messages.count)
    
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
            self.collectionView.reloadData()
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
    private func observeMessages(for tag: String) {
        FirebaseManager.observeMessages(for: tag) { (id, name, text) in
            print(id)
            print(name)
            print(text)
            // 4. Add the new message to the data source
            self.addMessage(withId: id, name: name, text: text)
            print(self.messages)
            // 5. Inform JSQMessagesViewController that a message has been received.
            self.finishReceivingMessage()
        }
        

    }
    
}
