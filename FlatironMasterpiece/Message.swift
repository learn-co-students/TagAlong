////
////  Message.swift
////  FlatironMasterpiece
////
////  Created by Erica Millado on 12/8/16.
////  Copyright © 2016 Elias Miller. All rights reserved.
////
//
//import Foundation
//
//struct Message {
//    var senderId: String
//    var senderName: String
//    var timeStamp: String
//    var text:String
//    
//    init(dict: [String:String]){
//        guard let senderId = dict["senderId"] else { return }
//        guard let senderName = dict["senderName"] else { return }
//        guard let timestamp = dict["timeStamp"] else { return }
//        guard let text = dict["text"] else { return }
//        self.senderId = senderId
//        self.senderName = senderName
//        self.timeStamp = timestamp
//        self.text = text
//        
//        
//        
//    }
//    
//    init(senderId:String, senderName:String, timeStamp:String, text:String){
//        self.senderId = senderId
//        self.senderName = senderName
//        self.timeStamp = timeStamp
//        self.text = text
//    }
//
//    
//    
//}
//
