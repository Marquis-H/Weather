//
//  Location.swift
//  Weather
//
//  Created by marquis on 16/2/1.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    var seenError: Bool = false
    
    var locationFixAchieved: Bool = false
    var locationStatus: NSString = "Not Started"
    var locationManager: CLLocationManager!
    var userLocation: String!
    var currLocation: CLLocation!
    
    var userLatitude: Double!
    var userLongitude: Double!
    var userCity: String?
}