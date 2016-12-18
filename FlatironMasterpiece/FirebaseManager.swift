
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

typealias tagalongInfoDict = [String:Any]

final class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    
    var currentUser: User!
    
    // Reference properties
    static var ref = FIRDatabase.database().reference().root
    static var storage = FIRStorage.storage()
    static var storageRef = storage.reference(forURL: "gs://newcarrots.appspot.com")
    //    static var chatRef: FIRDatabaseReference!
    static var chatsRef: FIRDatabaseReference!
    static let allChatsRef = FIRDatabase.database().reference().child("chats")
    static var newMessageRefHandle: FIRDatabaseHandle?
    static var newTagalongRefHandle: FIRDatabaseHandle?
    static var currentUser = FIRAuth.auth()?.currentUser?.uid
    static var currentUserEmail = FIRAuth.auth()?.currentUser?.email

    //    private var USER_REF = Firebase(url: "\(ref)/users")
    //    var USER_REF: Firebase {
    //        return USER_REF
    //    }
    
       
    // Tagalongs that populate tagalong tableview
    var tagalongs = [Tagalong]()
    
    //Tagalong ID from selected Tagalong
    var selectedTagAlongID: String?
    var guestID: String?
    var guestStatus = [String: Bool]()
    var hostTagAlongID: String?
    
    
    private init() {}
    
    //MARK: - Firebase user methods
    //this function is called in AccountCreationViewController, createAccountButton()
    
    
    static func sendToStorage(data: Data, handler: @escaping (Bool) -> Void) {
        
        guard let currentUser = FIRAuth.auth()?.currentUser?.uid else { handler(false); return }
      
        let storageRef = FIRStorage.storage().reference().child("\(currentUser).png")
        
        
        storageRef.put(data, metadata: nil, completion: { (metadata, error) in
            
            DispatchQueue.main.async {
                                
                if error != nil {
                    handler(false)
                    print(error!.localizedDescription)
                    return
                }
                
                guard let theMetaData = metadata else { return }
                
                
                let info = [
                    "ProfilePic" : theMetaData.downloadURL()!.absoluteString
                ]
                
                
                ref.child("users").child(currentUser).updateChildValues(info, withCompletionBlock: { error, ref in
                    
                    DispatchQueue.main.async {
                        
                        // Call on a completion?
                        
                        handler(true)
                        print("THIS IS A UID: \(currentUser)")
                    }

                })
              
                
                
            }
            
            
                   })
        
        
    }
    
    
    static func createNewUser(currentUser: User, completion: @escaping (Bool, User?) -> Void) {
        // 1 - create a new user in Firebase
        FIRAuth.auth()?.createUser(withEmail: currentUser.emailAddress, password: currentUser.passWord, completion: { (user, error) in
            guard error == nil, let rawUser = user else { completion(false, nil); return }
            //2 - save the new user in Firebase
            self.ref.child("users").child(rawUser.uid).setValue(currentUser.serialize(), withCompletionBlock: { error, ref in
              currentUser.userID = rawUser.uid
                
                guard error == nil else { completion(false, nil); return }
                completion(true, currentUser)
            })
        })
    }
    
    
    static func downloadPic(uid: String, handler: @escaping (UIImage) ->()) {
        let store = FirebaseManager.storageRef
        let userStore = store.child("\(uid).png")
        print(userStore)
        var userProfileImage = UIImage()
        userStore.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) -> Void in
            print(data)

            if error != nil {
                print(error?.localizedDescription)
                print("error")
            } else {
                print("image")
             userProfileImage = UIImage(data: data!)!
                handler(userProfileImage)

            }
        
        })
    }
    
    
    class func savePref(dictionary: [String: Any]) {
        var empArr: [String] = []
        print(dictionary)
        for pref in dictionary.keys {
            empArr.append(pref)
        }
        
        print("THis is the preferred array \(empArr)")
        UserDefaults.standard.set(empArr, forKey: "Preferences")
        
    }
    
    class func getUserPref() {
        
        let dict: [String] = []
        
        var preferencesdict = UserDefaults.standard.object(forKey: "Preferences") as? [String]
        guard let preferencesArray = preferencesdict else { return }
        //store in preferences
        preferencesdict = UsersDataStore.sharedInstance.preferredCuisineArray
        print(preferencesArray)
        
        
    }
    
    
    //this method gets preferences from firebase
    
    class func getPreferences() {
        //work with ELI to get the cuisines from Firebase
    }
    
    
    static func sendEmailVerification() {
        FIRAuth.auth()?.currentUser?.sendEmailVerification(completion: { (error) in
            if error == nil {
                print("Email sent")
            }
            else {
                print(error?.localizedDescription)
            }
        })
    }
    
    static func listenForLogIn() {
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
    
    static func loginToFirebase(email: String, password: String, completion: @escaping (Bool)-> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            guard error == nil else { completion(false); return }
            
            FirebaseManager.ref.child("users").child((user?.uid)!).observe(.value, with: { (snapshot) in
                let value = snapshot.value as? [String: Any]
                if let dict = value {
                    print(dict)
                    
                  let currentUser = User(snapshot: dict)
                    currentUser.userID = snapshot.key
                    FirebaseManager.shared.currentUser = currentUser
                }
              
                
            })

            completion(true)
        })
    }
    
    static func sendPasswordReset(email: String, completion: @escaping (Bool) -> Void) {
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            guard error == nil else { completion(false); return }
            completion(true)
        })
    }
    
    //MARK: - Firebase Facebook Methods
    static func facebookLogIn(completion: @escaping (Bool) -> Void) {
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
}


//MARK: - Block Methods

extension FirebaseManager {
    
    //////////////////////
    //WHAT JOHANN DID
    
    class func checkIfBlocked(userID: String, handler: @escaping (Bool) -> ()){
        guard let currentUser = FirebaseManager.currentUser else { print("no user printing"); return}
        FirebaseManager.ref.child("blockedID").child(userID).child(currentUser).observe(.value, with: { (snapshot) in
            let isBlocked = snapshot.value as? Bool

            if isBlocked != nil {
                handler(true)
            }else {
                handler(false)
            }
        })
    
    }
    
    class func block(userID: String, handler: @escaping (Bool) -> Void) {
        guard let currentUser = FirebaseManager.currentUser else { print("no user printing"); handler(false); return}
        
        let blockUserDictionary = [
            userID : true
        ]
      
        FirebaseManager.ref.child("blockedID").child(currentUser).setValue(blockUserDictionary, withCompletionBlock: { error, ref in
            if error == nil {
                handler(true)
            }
        })
        

    }
    
    
}
extension FirebaseManager {
    //MARK: - Firebase chat methods
    
    //1 - call this when a tagalong is created (restaurant card review) and
    static func createTagAlong(with tagAlongInfo: tagalongInfoDict, completion:@escaping (String?)-> Void) {
        
        // Outline of what the code should look like:
        let tagAlongsRef = FIRDatabase.database().reference().child("tagalongs")
        
        // Tagalong ID
        let tagAlongIDRef = tagAlongsRef.childByAutoId()
        
        // Tagalong Key
        let tagAlongIDKey = tagAlongIDRef.key
        
        // Add Tagalong dictionary to Tagalong ID
        tagAlongIDRef.updateChildValues(tagAlongInfo, withCompletionBlock: { error, ref in
            if error != nil { print(error!.localizedDescription); completion(nil); return }
            print("hey there")
            
            completion(tagAlongIDKey)
            
            print(tagAlongIDKey)
            print("after completion")
        })
        
        
        
    }
    
    static func updateUserWithTagAlongKey(key: String) {
      
//            guard let currentUser = FIRAuth.auth()?.currentUser?.uid else { return }
        print("Current user: \(FIRAuth.auth()?.currentUser?.uid)")
            ref.child("users").child(currentUser!).child("tagalongs").updateChildValues([key: true])
            ref.child("users").child(currentUser!).child("currentTagalongs").setValue([key: true])
    }
    
    
    ///this gets called in searchingForTagAlongVC (acceptTagalong())
    func updateGuestWithTagAlongKey(tagAlongkey: String) {
        guard let unwrappedGuestID = guestID else { return }
        FirebaseManager.ref.child("users").child(unwrappedGuestID).child("tagalongs").updateChildValues([tagAlongkey: true])
        FirebaseManager.ref.child("users").child(unwrappedGuestID).child("currentTagalongs").setValue([tagAlongkey: true])
    }
    
    
    static func createUserFrom(tagalong: String, completion: @escaping (User) -> ()) {
        
        FirebaseManager.ref.child("tagalongs").child(tagalong).child("user").observeSingleEvent(of: .value, with: { (snapshot) in
            let userName = snapshot.value as! String
            
            // This will need to be replaced with the userID
            FirebaseManager.ref.child("users").child(userName).observe(.value, with: { (snapshot) in
                
                let userInfo = snapshot.value as? [String: Any]
                
                
                if let userDict = userInfo {
                    print(snapshot)
                    print(userDict)

                    let user = User(snapshot: userDict)
                    user.userID = userName
                    print("=-=-=-=-=-=-= \(userInfo)-=-=-=-=-=-=-=-=")
                    //self.newtagalongUserArray.append(user)
                    completion(user)
                }
                
            })
        })
    }
    
    
    
    //MARK: - Tagalong Message Methods
    
    static func createChatWithTagID(key: String) {
        self.chatsRef = allChatsRef.child("\(key)")
    }
    
    
    static func joinChat(with tagId:String, completion:()->()){
        self.chatsRef = allChatsRef.child("\(tagId)")
        self.chatsRef.observe(.childAdded, with: { (snapshot) in
            print(snapshot.value)
        })
    }
    
    
    static func observeTagalongs(completion: @escaping (String) -> Void) {
        newTagalongRefHandle = ref.child("tagalongs").observe(.childAdded, with: { (snapshot) -> Void in
            print("--------------------GETTING CALLED------------------")
            print("tagalongQuery snapshot: \(snapshot.value)")
            print("tagalongKey: \(snapshot.key)")
            
            if let tagalongKey = snapshot.key as? String,
                let tagalongValue = snapshot.value as? [String: Any] {
                completion(tagalongKey)
            } else {
                print("Error! Could not decode message data")
            }
            print("----------------------------------------------\n\n\n")
        })
    }
    
    // Request a tagalong
    static func requestTagAlong(key: String) {
        guard let currentUser = currentUser else { return }
        ref.child("tagalongs").child("\(key)").child("guests").updateChildValues([currentUser : false])
        
    }
    
    func observeTagalongRequests(response: @escaping (FIRDataSnapshot?) -> Void) {
        //guard let currentUser = FirebaseManager.currentUser else { print("hey coming out as nil");return}
        let currentUser = self.currentUser.userID
        FirebaseManager.ref.child("users").child("\(currentUser)").child("currentTagalongs").observe(.childAdded, with: { (snapshot) in
            let currentTagalong = snapshot.key
            print("Current Tagalong from observe requests -> \(currentTagalong)")
            FirebaseManager.ref.child("tagalongs").child("\(currentTagalong)").child("guests").observe(.childAdded, with: { snapshot in
                print(snapshot)
                DispatchQueue.main.async {
                    response(snapshot)
                }
            })
        })
    }
    
    func createGuest(from guestID: String, completion: @escaping (User) -> Void) {
        FirebaseManager.ref.child("users").child("\(guestID)").observe(.value, with: { (snapshot) in

            let userInfo = snapshot.value as? [String: Any]
            if let userDict = userInfo {
                let user = User(snapshot: userDict)
                print("=-=-=-=-=-=-= \(userInfo)-=-=-=-=-=-=-=-=")
                completion(user)
            }
        })
    }
    
    func acceptTagalong(guestID: String, completion: @escaping (String)-> Void) {
       // guard let currentUser = FirebaseManager.currentUser else { print("hey coming out as nil");return}
        let currentUser = self.currentUser.userID
        FirebaseManager.ref.child("users").child("\(currentUser)").child("currentTagalongs").observe(.childAdded, with: { (snapshot) in
            let currentTagalong = snapshot.key
            print("Current Tagalong -> \(currentTagalong)")
            FirebaseManager.ref.child("tagalongs").child("\(currentTagalong)").child("guests").updateChildValues([guestID : true])
            completion(currentTagalong)
        })
    }
    
    func denyTagalong(guestID: String) {
        //guard let currentUser = FirebaseManager.currentUser else { print("hey coming out as nil");return}
        let currentUser = self.currentUser.userID
        FirebaseManager.ref.child("users").child("\(currentUser)").child("currentTagalongs").observe(.childAdded, with: { (snapshot) in
            let currentTagalong = snapshot.key
            print("Current Tagalong -> \(currentTagalong)")
            
            FirebaseManager.ref.child("tagalongs").child("\(currentTagalong)").child("guests").updateChildValues([guestID : "none"])
        })
    }
    
    func observeGuestTagalongStatus(completion: @escaping (FIRDataSnapshot?) -> Void) {
        
        //guard let guestID = FirebaseManager.currentUser else { print("hey retuning");return }
        let guestID = currentUser.userID
        guard let selectedTag = selectedTagAlongID else { print("selected tag along is nil");return}
        
        print("firebase manager observe guest tagalong - selected tag: \(selectedTag)")
        
        FirebaseManager.ref.child("tagalongs").child("\(selectedTag)").child("guests").child("\(guestID)").observe(.value, with: { (snapshot) in
            completion(snapshot)
        })
    }
    
    func hideTagalong(for tagalong: String) {
        print("-------> \(tagalong) <-------")
        FirebaseManager.ref.child("tagalongs").child(tagalong).child("hidden").setValue(true)
    }
    
    
    static func sendMessage(senderId:String, senderDisplayName: String, text: String, date: Date, messageCount: Int) {
        
        print("\n\nFirebaseManager sendMessage:\nsenderId: \(senderId)\nsenderDisplayName: \(senderDisplayName)\ntext: \(text)\ndate: \(date)\nself.messages.count: \(messageCount)\n\n")
        
        let itemRef = self.chatsRef.childByAutoId()
        let messageItem = [ // 2
            "senderId": senderId,
            "senderName": senderDisplayName,
            "text": text,
            "timestamp": String(Int(Date().timeIntervalSince1970))
        ]
        
        itemRef.setValue(messageItem, withCompletionBlock: { error, ref in
        })
        
        print("\n\nFirebaseManager sendMessage:\nchatRef: \(self.chatsRef)\n\n")
        
        //        self.chatRef.updateChildValues(["\(messageCount)": messageItem])
        
    }
    
    static func observeMessages(for tagalong:String, completion: @escaping (String, String, String) -> Void) {
        print(tagalong)
        
        self.chatsRef = FirebaseManager.allChatsRef.child("\(tagalong)")
        let chatQuery = chatsRef.queryLimited(toLast:25)
        
        let newChatsRefHandle = chatQuery.observe(.childAdded, with: { snapshot in
            
            let messageData = snapshot.value as! [String : String]
            
            guard let id = messageData["senderId"] ,
                let name = messageData["senderName"] ,
                let text = messageData["text"] else { completion("", "", ""); return }
            
            completion(id, name, text)
        })
    }
}
