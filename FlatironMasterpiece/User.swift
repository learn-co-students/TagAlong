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


    let image = UIImageView()

    let cuisines = [String]()
//    let currentTagalong: String?


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


    init(snapshot: [String: Any]){
        let firstName = snapshot["firstName"] as! String
        let lastName = snapshot["lastName"] as! String
        let email = snapshot["email"] as! String
        let jobTitle = snapshot["jobTitle"] as! String
        let industry = snapshot["industry"] as! String
//        let currentTagAlong = snapshot["currentTagAlong"] as! String
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
