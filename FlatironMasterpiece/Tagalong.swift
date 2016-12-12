//
//  Tagalong.swift
//  FlatironMasterpiece
//
//  Created by Joyce Matos on 12/6/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation

struct Tagalong{
    
    var tagID: String
    var date: String
    var latitude: Double
    var longitude: Double
    var restaurant: String
    var user: User!
    var hidden: Bool
    var guest = ""
    
    init(snapshot: [String: Any], tagID: String) {
        print(snapshot)
        
        let user = snapshot["user"] as! String
        let hidden = snapshot["hidden"] as! Bool
        let dateValue = snapshot["date"] as! Double
        let location = snapshot["location"] as! [String: Any]
        let latitude = location["lat"] as! Double
        let longitude = location["long"] as! Double
        let restaurant = location["restaurant"] as! String
        
        
        // Need to set location to equal dictionary of lat, long, restaurant
        self.hidden = hidden
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        let date = Date(timeIntervalSince1970: dateValue)
        let dateString = dateFormatter.string(from: date)
        
        self.date = dateString
        self.longitude = longitude
        self.latitude = latitude
        self.restaurant = restaurant
        self.tagID = tagID
    }
    
    func serialize()->[String:Any] {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        let date = dateFormatter.date(from: self.date)?.timeIntervalSince1970 ?? 0.0
    
        return [
            "user" : FirebaseManager.currentUser,
            "hidden" : false,
            "date" : Double(date),
            "location" : [
                "restaurant" : self.restaurant,
                "lat" : self.latitude,
                "long": self.longitude,
            ]
        ]

    }
    
    

}
