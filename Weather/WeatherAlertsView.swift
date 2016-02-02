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
        if let result = (weatherDictionary["result"] as! NSDictionary!){
            let pm = result["pm25"] as! NSDictionary
            let pm25 = pm["pm25"] as! NSDictionary
            userAlert = pm25["des"] as! String
        }else{
            userAlert = ""
        }
    }
}
