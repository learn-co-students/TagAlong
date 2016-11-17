//
//  Location.swift
//  FlatironMasterpiece
//
//  Created by Elias Miller on 11/15/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation
class Location {
    var latitude: Double
    var longitude: Double
    var timeStampOfLocation: Double
    var location = [Double : Double]()
    
    init(latitude: Double, longitude: Double, timeStampOfLocation: Double) {
        self.latitude = latitude
        self.longitude = longitude
        self.timeStampOfLocation = timeStampOfLocation
    }
    
    
}
