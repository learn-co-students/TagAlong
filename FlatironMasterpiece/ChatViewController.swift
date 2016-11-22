//
//  ChatViewController.swift
//  FlatironMasterpiece
//
//  Created by Joyce Matos on 11/21/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import JSQMessagesViewController

final class ChatViewController: JSQMessagesViewController {
    
    // MARK: Properties
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    var messages = [JSQMessage]()    // Stores messages
    var channelRef: FIRDatabaseReference?
    var matchChannel: Match? {
        didSet {
            title = matchChannel?.name
        }
    }
    
    // References the 'messages' child within the channel
    private lazy var messageRef: FIRDatabaseReference = self.channelRef!.child("messages")
    private var newMessageRefHandle: FIRDatabaseHandle?
    
    
    // Update Firebase when user is typing:
    // 1. Create a Firebase reference that tracks whether the local user is typing.
    private lazy var userIsTypingRef: FIRDatabaseReference =
        self.channelRef!.child("typingIndicator").child(self.senderId)
    // 2. Store whether the local user is typing in a private property.
    private var localTyping = false
    var isTyping: Bool {
        get {
            return localTyping
        }
        set {
            // 3. Use a computed property to update localTyping and userIsTypingRef each time it’s changed.
            localTyping = newValue
            userIsTypingRef.setValue(newValue)
        }
    }
    
    
    // Creates a child reference to your channel called typingIndicator, which is where you’ll update the typing status of the user.
    private func observeTyping() {
        let typingIndicatorRef = channelRef!.child("typingIndicator")
        userIsTypingRef = typingIndicatorRef.child(senderId)
        userIsTypingRef.onDisconnectRemoveValue()
    }
    
    
    
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the senderId based on the logged in Firebase user.
        self.senderId = FIRAuth.auth()?.currentUser?.uid
        
        //This tells the layout to size each avatar at CGSize.zero, which is “no size”.
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        // Observe messages
        observeMessages()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observeTyping()
    }
    
    
    
    // Make send button save a message to firebase
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let itemRef = messageRef.childByAutoId() // 1
        let messageItem = [ // 2
            "senderId": senderId!,
            "senderName": senderDisplayName!,
            "text": text!,
            ]
        
        itemRef.setValue(messageItem) // 3
        
        
        // message sent sound
        JSQSystemSoundPlayer.jsq_playMessageSentSound() // 4
        
        // animates sending of message
        finishSendingMessage() // 5
        
        
        // Reset the typing indicator when the Send button is pressed.
        isTyping = false
        
    }
    
    //  override func viewDidAppear(_ animated: Bool) {
    //    super.viewDidAppear(animated)
    //
    //    // Hard coded dummy message
    //    // messages from someone else
    //    addMessage(withId: "foo", name: "Mr.Bolt", text: "I am so fast!")
    //    // messages sent from local sender
    //    addMessage(withId: senderId, name: "Me", text: "I bet I can run faster than you!")
    //    addMessage(withId: senderId, name: "Me", text: "I like to run!")
    //    // animates the receiving of a new message on the view
    //    finishReceivingMessage()
    //  }
    
    
    
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
    
    // Remove avatars (anonymous chat) -- this is why we return nil
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    
    // MARK: Firebase related methods
    
    
    // MARK: UI and User Interaction
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    
    // MARK: Create Messages/ Create JSQMessage objects and append to array
    
    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
        }
    }
    
    
    // MARK: Synchronize Data Source
    
    private func observeMessages() {
        messageRef = channelRef!.child("messages")
        
        // 1. Creating a query that limits the synchronization to the last 25 messages
        let messageQuery = messageRef.queryLimited(toLast:25)
        
        // 2. Observe every child item that has been added, and will be added, at the messages location.
        
        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
            
            // 3. Extract the messageData from the snapshot
            
            let messageData = snapshot.value as! Dictionary<String, String>
            
            if let id = messageData["senderId"] as String!, let name = messageData["senderName"] as String!, let text = messageData["text"] as String!, text.characters.count > 0 {
                
                // 4. Add the new message to the data source
                
                self.addMessage(withId: id, name: name, text: text)
                
                // 5. Inform JSQMessagesViewController that a message has been received.
                self.finishReceivingMessage()
            } else {
                print("Error! Could not decode message data")
            }
        })
    }
    
    // Mark: Alert when user is typing
    
    override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        // If the text is not empty, the user is typing
        isTyping = textView.text != ""
    }
    
    // MARK: UITextViewDelegate methods
    
    
    
}





//class ChatViewController: JSQMessagesViewController {
//
//    // Stores user's name and match
//    var userName: String?
//    var matchChannel: Match!
//    
//    // Creates reference to match channel
//    private lazy var matchRef: FIRDatabaseReference = FIRDatabase.database().reference().child("matchChannel")
//    private var matchRefHandle: FIRDatabaseHandle?
//    
//    
//    func createMatchChannel() {
//        
//        // User has been matched and a match channel will contain the messages
//        let newMatchRef = matchRef.childByAutoId() // 2
//        let matchItem = [ // 3
//            "name": userName
//        ]
//        newMatchRef.setValue(matchItem) // 4m
//}
//
//
//
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let matchChannel = Match(id: "Match", name: "Match Channel")
//        
//        createMatchChannel()
//        
//        view.backgroundColor = UIColor.white
//
//        chatView.translatesAutoresizingMaskIntoConstraints = false
//        chatView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250).isActive = true
//        chatView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//        chatView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
//        chatView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50).isActive = true
//
//        
//        
//        
//        chatView.delegate = self
//        chatView.dataSource = self
//        chatView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        
//        self.view.addSubview(chatView)
        
//    }


    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
//        cell.textLabel?.text = messages[indexPath.row]
//        
//        return cell
//    }
//
//    
//
//
//}
