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
        
        var query = ""
            switch queryString {
            case "American":
            query = "american"
            case "Asian":
            query = "asian"
            case "Italian":
            query = "italian"
            case "Healthy":
            query = "healthy"
            case "Latin":
            query = "latin"
            default:
            query = "vegetarian"
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
    
    class func getRestImages(photoRef: String, completion: @escaping (Data?) -> Void) {
        let photoSearchUrlString = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(photoRef)&key=\(gpSearchApiKey)"
        let url = URL(string: photoSearchUrlString)
        
        guard let unwrappedURL = url else { completion(nil); return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: unwrappedURL) { (data, response, error) in
            
            DispatchQueue.main.async {
                completion(data)
            }
            
        }
        dataTask.resume()
    }
    
//end of class
}














