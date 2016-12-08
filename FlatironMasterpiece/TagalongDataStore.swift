//
//  TagalongDataStore.swift
//  FlatironMasterpiece
//
//  Created by Joyce Matos on 12/5/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation
import UIKit

final class TagalongDataStore {
    
    static let shared = TagalongDataStore()
    
    var selectedRestaurant: String?
    var hostIndustry: String?
    var guestDistance: Double?
    var tagalongID: String?
    var hostName: String?
    var hostPhoto: UIImage?
    var hostKey: String?
    
    private init() {}
    
    
    
    
}
