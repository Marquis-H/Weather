//
//  WeatherData.swift
//  Weather
//
//  Created by marquis on 16/2/1.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation

struct WeatherData {
    let baseURL = NSURL(string: weatherApi)
    let sharedSession = NSURLSession.sharedSession()
}