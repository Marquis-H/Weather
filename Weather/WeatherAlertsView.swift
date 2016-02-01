//
//  WeatherAlerts.swift
//  Weather
//
//  Created by marquis on 16/2/1.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation
import UIKit

struct WeatherAlertsView {
    var userAlert: String
    
    init (weatherDictionary: NSDictionary){
        if let WeatherAlerts = (weatherDictionary["result"] as! NSArray!){
            userAlert = WeatherAlerts[0]["pm25"]!!["pm25"]!!["des"] as! String
        }else{
            userAlert = ""
        }
    }
}
