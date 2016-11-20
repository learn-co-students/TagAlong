//
//  Location.swift
//  FlatironMasterpiece
//
//  Created by Elias Miller on 11/15/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation

class Location {
    var name: String
    var priceLevel: Int
//    var openNow: Int
    var latitude: Double
    var longitude: Double
    var timeStampOfLocation: Double
    var location = [Double : Double]()
    
    init(name: String, priceLevel:Int,   latitude: Double, longitude: Double, timeStampOfLocation: Double) {
        self.name = name
        self.priceLevel = priceLevel
//        self.openNow = openNow
        self.latitude = latitude
        self.longitude = longitude
        self.timeStampOfLocation = timeStampOfLocation
    }
    
}
