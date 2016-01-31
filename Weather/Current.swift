//
//  Current.swift
//  Weather
//
//  Created by Marquis on 16/1/30.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation
import UIKit

struct Current {
    var currentTime: String?
    var temperature: Int?
    var windSpeed:   Double?
    var pm:          Double?
    var humidity:    Double?
    var icon:        UIImage?
    var summary:     String = ""
}