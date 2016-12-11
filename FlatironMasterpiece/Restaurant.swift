//
//  Restaurant.swift
//  FlatironMasterpiece
//
//  Created by Elias Miller on 11/15/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation
import UIKit

class Restaurant {
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var name: String?
    var openNow: Bool = false
    var photoRef: String = ""
    var noPhotoRef: String?
    var photoImage: UIImage?
    var priceLevel: Int?
    var restaurantRating: Int?
    var timeStampOfLocation: Double?
    
    init(dictionary: json) {
        
        //gets address (as string)
        let restaurantAddress = dictionary["formatted_address"] as? String
        address = restaurantAddress
        //gets restaurant lat and long
        let restaurantGeometryDict = dictionary["geometry"] as! restaurantDictionary
        let restaurantLatLongDict = restaurantGeometryDict["location"] as! restaurantDictionary
        if let uLatitude = restaurantLatLongDict["lat"] as? Double? {
            latitude = uLatitude
            print("This is the restaurantLat \(latitude)")
        }
        if let ulongitude = restaurantLatLongDict["lng"] as? Double? {
            longitude = ulongitude
            print("This is the restaurantLong \(longitude)")
        }
        
        //gets restaurant name
        if let uname = dictionary["name"] as? String? {
            name = uname
            print("This is the restaurant name \(name)")
        }
        
        //gets if restaurant is open now
        if let restHoursDict = dictionary["opening_hours"] as? [String : Any] {
            if let item = restHoursDict["open_now"]  {
                if let number = item as? NSNumber {
                   let this = Int(number)
                    if this == 1 {
                        self.openNow = true
                    } else {
                        self.openNow = false
                    }
                }
            } else {
                print("&&&&&&&&&&&&&")
            }
        }
        
        //NOTE: - ELI, this is what I wrote so far for the missing image
        if let noPhotoReference = dictionary["reference"] as? String {
            print("\n\nno photo reference \(noPhotoReference)")
            if noPhotoReference != "" {
                self.photoImage = UIImage(named: "fork_red")
            }
        }
    
        //gets restaurant photoref
        if let restPhotoArray = dictionary["photos"] as? [[String:Any]] {
            let photoDict = restPhotoArray[0]
            if let rawPhotoRef = photoDict["photo_reference"] {
                print("\n\nthis is the rawPhotoRef: \(rawPhotoRef)")
                if let photoString = rawPhotoRef as? NSString {
                    self.photoRef = String(photoString)
                    APIClientGooglePlaces.getRestImages(photoRef: photoRef, completion: { (data) in
                        if let rawData = data {
                            self.photoImage = UIImage(data: rawData)
                        }
                    })
                }
            }
        }
        
        //if rest has NO photo
        if let noPhotoRef = dictionary["reference"] as? String {
            self.noPhotoRef = noPhotoRef
        }
        
        //gets restaurant price level
        if let uPriceLevel = dictionary["price_level"] as? Int? {
            priceLevel = uPriceLevel
            print("This is the restaurant's price level \(priceLevel)")
        }
        
        //gets restaurant rating
        if let urestaurantRating = dictionary["rating"] as? Int? {
            restaurantRating = urestaurantRating
            print("This is the restaurant's rating \(restaurantRating)")
        }
        
    }
    
}
