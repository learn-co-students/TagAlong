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
    
    //1 -create a favoriteCuisines property from a bunch of cuisines
//    let faveCuisine1: String
//    let faveCuisine2: String
//    let faveCuisine3: String
//    let faveCuisine4: String
//    let faveCuisine5: String
//    let faveCuisine6: String
//    var favoriteCuisines: [String] {
//        return [faveCuisine1, faveCuisine2, faveCuisine3, faveCuisine4, faveCuisine5, faveCuisine6]
//    }
    
    init(firstName: String, lastName:String, emailAddress: String, passWord: String, industry: String, jobTitle: String) {
        
//    init(firstName: String, lastName:String, emailAddress: String, passWord: String, industry: String, jobTitle: String, faveCuisine1: String, faveCuisine2: String, faveCuisine3: String, faveCuisine4: String, faveCuisine5: String, faveCuisine6: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.passWord = passWord
        self.industry = industry
        self.jobTitle = jobTitle
        
        //2- initialize the favecuisines
//        self.faveCuisine1 = faveCuisine1
//        self.faveCuisine2 = faveCuisine2
//        self.faveCuisine3 = faveCuisine3
//        self.faveCuisine4 = faveCuisine4
//        self.faveCuisine5 = faveCuisine5
//        self.faveCuisine6 = faveCuisine6
    }
    
    func serialize() -> [String : String] {
        return [
            "email" : emailAddress,
            "firstName" : firstName,
            "lastName" : lastName,
            "jobTitle" : jobTitle,
            "industry" : industry,
            //3 - include the favoritecuisinesarray
//            "favoriteCuisines": favoriteCuisines
        ]
    }
    

    
}
