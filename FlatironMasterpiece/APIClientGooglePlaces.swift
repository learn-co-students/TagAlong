//
//  APIClient.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/15/16.
//  Copyright © 2016 Erica Millado. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreLocation

typealias json = [String:Any]

class APIClientGooglePlaces {
    
    class func getRestaurants(lat:Double, long:Double, queryString:String, completion:@escaping(json)-> Void) {
        
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(long)&radius=800&types=restaurant&key=\(gpSearchApiKey)"
        
        //https://maps.googleapis.com/maps/api/place/textsearch/json?location=40.748944899999998,-74.0002432&radius=800&type=restaurant&query=mexican&key=AIzaSyCHpMNpmqweioW5MyGZqpqtDEzg8r67Fio
        
        var query = ""
        
        switch queryString {
            case "american":
            query = "cheeseburger+sandwich+steak+seafood+american"
            case "asian":
            query = "chinese+japanese+sushi+thai+korean+asian"
            case "italian":
            query = "pizza+pasta+seafood+meatballs+italian"
            case "healthy":
            query = "salads+healthy+smoothies+tea"
            case "latin":
            query = "latin+mexican+taco+burrito"
            default:
            query = "fastfood"
        }
        
        let textSearchUrlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?location=\(lat),\(long)&radius=800&type=restaurant&query=\(query)&key=\(gpSearchApiKey)"
        
        let url = URL(string: textSearchUrlString)
    
        guard let unwrappedURL = url else { print("error at url"); return }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: unwrappedURL) { (data, response, error) in
            guard let unwrappedData = data else { print("error at data"); return }
            do {
                var responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! json
                completion(responseJSON)
            } catch {
                print("error in getting responseJSON")
            }
        }
        dataTask.resume()
        
    }
}

