//
//  ChatroomTestViewController.swift
//  FlatironMasterpiece
//
//  Created by Joyce Matos on 11/30/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

//import UIKit
//import Firebase
//
//class ChatroomTestViewController: UIViewController {
//
//    @IBAction func chatWithChristina(_ sender: Any) {
//        
//        
//        self.performSegue(withIdentifier: "showChristina", sender: self)
//
//        
//    }
//    
//    @IBAction func chatWithErica(_ sender: Any) {
//        
//        self.performSegue(withIdentifier: "showErica", sender: self)
//
//    }
//    
//    @IBAction func chatWithNick(_ sender: Any) {
//        
//        self.performSegue(withIdentifier: "showNick", sender: self)
//
//    }
//    
//    @IBAction func chatWithEli(_ sender: Any) {
//        
//        self.performSegue(withIdentifier: "showEli", sender: self)
//
//    }
//    
//    @IBAction func chatWithJoyce(_ sender: Any) {
//        
//        self.performSegue(withIdentifier: "showJoyce", sender: self)
//
//    }
//    
//    
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showChristina" {
//            
//            let chatVC = segue.destination as! ChatViewController
//            let allChatsRef = FIRDatabase.database().reference().child("chats")
//            // chatRef should point to only one single chat --- eventually Auto ID
//            chatVC.chatRef = allChatsRef.child("christinaChat")
//            
//        }
//        
//        if segue.identifier == "showErica" {
//            
//            let chatVC = segue.destination as! ChatViewController
//            let allChatsRef = FIRDatabase.database().reference().child("chats")
//            // chatRef should point to only one single chat --- eventually Auto ID
//            chatVC.chatRef = allChatsRef.child("ericaChat")
//            
//        }
//        
//        if segue.identifier == "showNick" {
//            
//            let chatVC = segue.destination as! ChatViewController
//            let allChatsRef = FIRDatabase.database().reference().child("chats")
//            // chatRef should point to only one single chat --- eventually Auto ID
//            let key = allChatsRef.childByAutoId()
//            chatVC.chatRef = allChatsRef.child("\(key)")
//            
//            
//            
//            
//            // Pseudo code: if user in database has a tagalong that matches this key && is < 12 hours ,
//               // segue back into this chat using this key
//            
//            
//        }
//        
//        if segue.identifier == "showEli" {
//            
//            let chatVC = segue.destination as! ChatViewController
//            let allChatsRef = FIRDatabase.database().reference().child("chats")
//            // chatRef should point to only one single chat --- eventually Auto ID
//            chatVC.chatRef = allChatsRef.child("eliChat")
//            
//        }
//        
//        if segue.identifier == "showJoyce" {
//            
//            let chatVC = segue.destination as! ChatViewController
//            let allChatsRef = FIRDatabase.database().reference().child("chats")
//            // chatRef should point to only one single chat --- eventually Auto ID
//            chatVC.chatRef = allChatsRef.child("joyceChat")
//            
//        }
//        
//        
//        
//    }
// 
//
//}
