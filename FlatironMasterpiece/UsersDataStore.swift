//
//  UsersDataStore.swift
//  FlatironMasterpiece
//
//  Created by Elias Miller on 11/16/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//
import Foundation

class UsersDataStore {
    
    static let sharedInstance = UsersDataStore()
    fileprivate init() {}
    
    var users: [User] = []
    
    var preferredCuisineArray:[String] = []
    
    var currentChosenCuisine:String = ""
    var chosenRestName:String = ""
    var chosenRestAddress:String = ""
    var chosenRestPriceLevel: Int = 0
    var chosenRestPriceEmojis:String {
        switch chosenRestPriceLevel {
        case 1:
            return "💰"
        case 2:
            return "💰💰"
        case 3:
            return "💰💰💰"
        case 4:
            return "💰💰💰💰"
        default:
            return "💰💰"
        }
    }
    
    //ERICA's NOTES - this property might be deleted
    var userBudgetChoice:Int = 1
    
    //get this from firebase user login data
    //    func getUsersFromDatabase {
    //firstname
    //industry
    //jobtitle
    //}
    
    
    
    
}
