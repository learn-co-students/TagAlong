//
//  User.swift
//  FlatironMasterpiece
//
//  Created by Elias Miller on 11/15/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//
import Foundation
import Firebase


class User {
    let firstName: String
    let lastName: String
    let emailAddress: String
    let passWord: String
    let industry: String
    let jobTitle: String
    let storage = FIRStorage.storage().reference()
    var userID: String = ""

    let image = UIImageView()

    let cuisines = [String]()
//    let currentTagalong: String?


    init(snapshot: [String: Any]){
        
        let firstName = snapshot["firstName"] as! String
        let lastName = snapshot["lastName"] as! String
        let email = snapshot["email"] as! String
        let jobTitle = snapshot["jobTitle"] as! String
        let industry = snapshot["industry"] as! String
//        let currentTagAlong = snapshot["currentTagAlong"] as! String
       let userID = snapshot["ID"] as? String ?? ""
        
        self.userID = userID
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = email
        self.jobTitle = jobTitle
        self.industry = industry

        self.passWord = ""
    }

    init(firstName: String, lastName:String, emailAddress: String, passWord: String, industry: String, jobTitle: String) {

        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.passWord = passWord
        self.industry = industry
        self.jobTitle = jobTitle
        
}

    func serialize() -> [String : String] {
        return [
            "email" : emailAddress,
            "firstName" : firstName,
            "lastName" : lastName,
            "jobTitle" : jobTitle,
            "industry" : industry,

        ]
    }

}
