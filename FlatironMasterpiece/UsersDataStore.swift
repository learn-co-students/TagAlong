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
    
    var userBudgetChoice:Int = 1
    
    //get this from firebase user login data
    //    func getUsersFromDatabase {
    //firstname
    //industry
    //jobtitle
    //}
    
    
    //this function stores returned restaurant search data for a user
    func getRestaurantsByPreference() {
        
    }
    
//    AMERICAN
//    https://maps.googleapis.com/maps/api/place/textsearch/json?location=40.748944899999998,-74.0002432&radius=800&type=restaurant&query=cheeseburger+sandwich+steak+seafood&key=AIzaSyCHpMNpmqweioW5MyGZqpqtDEzg8r67Fio
//    
//    ASIAN
//    https://maps.googleapis.com/maps/api/place/textsearch/json?location=40.748944899999998,-74.0002432&radius=800&type=restaurant&query=chinese+japanese+sushi+thai+korean&key=AIzaSyCHpMNpmqweioW5MyGZqpqtDEzg8r67Fio
//    
//    ITALIAN
//    https://maps.googleapis.com/maps/api/place/textsearch/json?location=40.748944899999998,-74.0002432&radius=800&type=restaurant&query=pizza+pasta+seafood+meatballs&key=AIzaSyCHpMNpmqweioW5MyGZqpqtDEzg8r67Fio
//    
//    HEALTHY
//    https://maps.googleapis.com/maps/api/place/textsearch/json?location=40.748944899999998,-74.0002432&radius=800&type=restaurant&query=salads+healthy+smoothies+tea&key=AIzaSyCHpMNpmqweioW5MyGZqpqtDEzg8r67Fio
//    
//    LATIN
//    https://maps.googleapis.com/maps/api/place/textsearch/json?location=40.748944899999998,-74.0002432&radius=800&type=restaurant&query=latin+mexican+taco+burrito&key=AIzaSyCHpMNpmqweioW5MyGZqpqtDEzg8r67Fio
//    
//    UNHEALTHY
//    https://maps.googleapis.com/maps/api/place/textsearch/json?location=40.748944899999998,-74.0002432&radius=800&type=restaurant&query=fastfood+burger+pizza+candy+icecream&key=AIzaSyCHpMNpmqweioW5MyGZqpqtDEzg8r67Fio
    
    
}
