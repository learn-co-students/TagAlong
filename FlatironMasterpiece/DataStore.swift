//
//  DataStore.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/17/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation

class DataStore {
    static let sharedInstance = DataStore()
    private init() {}
    
    var userLatitude = Double()
    var userLongitude = Double()
}
