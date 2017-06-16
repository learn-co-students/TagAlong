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
    
    //var preferredCuisineArray:[String] = []
    
    //ERICA needs to figure out this prefCuisine prop Johann wrote
    var preferredCuisineArray: [String]{
        get {
            let prefs = UserDefaults.standard.object(forKey: "UserCuisineArray") as? [String] ?? []
            
            return prefs
        }
        
        set{
            
            
            UserDefaults.standard.set(newValue, forKey: "UserCuisineArray")
        }
    }
    
    var userLat: Double = 0.0
    var userLong: Double = 0.0
    
    var currentChosenCuisine:String = ""
    var chosenRestLat: Double = 0.0
    var chosenRestLong: Double = 0.0
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
    var userDistanceToChosenRest: Double = 0.0
    
    //ERICA's NOTES - this property might be deleted
    var userBudgetChoice:Int = 1
    
    //get this from firebase user login data
    //    func getUsersFromDatabase {
    //firstname
    //industry
    //jobtitle
    //}
    
    
    
    
}
