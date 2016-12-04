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
    let cuisines = [String]()
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
