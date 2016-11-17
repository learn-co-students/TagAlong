//
//  LocationDataStore.swift
//  FlatironMasterpiece
//
//  Created by Elias Miller on 11/17/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//
import Foundation

class LocationDataStore {
    static let sharedInstance = LocationDataStore()
    var location: [Location]!
    
    fileprivate init() {}
    
    
}
