//
//  CurrentViewModel.swift
//  Weather
//
//  Created by Marquis on 16/1/31.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation
import UIKit

public class CurrentViewModel {

    weak var delegate: CurrentViewDelegate?
    var current : Current = Current()
    //Mark: - Initialization
    init(weatherDictionary: NSDictionary){
        initData(self.packageData(weatherDictionary))
    }
    
    func initData(weatherDictionary: NSDictionary){
        current.temperature = (weatherDictionary["temperature"] as! Int)
        current.windSpeed = (weatherDictionary["windSpeed"] as! Double)
        current.pm = (weatherDictionary["pm25"] as! Double)
        current.humidity = (weatherDictionary["humidity"] as! Double)
        current.summary = weatherDictionary["summary"] as! String
        let iconString = weatherDictionary["icon"] as! String
        current.icon = self.weatherIconFromString(iconString)
        current.currentTime = (weatherDictionary["currentTime"] as! String)
    }
}

//MARK: - Image
extension CurrentViewModel{
    func weatherIconFromString(iconString: String) -> UIImage{
        var imageName: String
        
        switch iconString {
        case "0":
            imageName = "clear-day"
        case "1":
            imageName = "cloudy"
        case "2":
            imageName = "partly-cloudy"
        default:
            imageName = "default"
        }
        
        return UIImage(named: imageName)!
    }
}

//MARK - Package Data
extension CurrentViewModel{
    func packageData(weatherDictionary: NSDictionary) -> NSDictionary{
        //Base Data
        let realtime = weatherDictionary["realtime"] as! NSDictionary
        let pm = weatherDictionary["pm25"] as! NSDictionary
        let pm25 = pm["pm25"] as! NSDictionary
        let weather = realtime["weather"] as! NSDictionary
        let wind = realtime["wind"] as! NSDictionary
        
        return [
            "temperature": weather["temperature"] as! Int,
            "windSpeed": wind["windspeed"] as! Double,
            "pm25": pm25["pm25"] as! Double,
            "humidity": weather["humidity"] as! Double,
            "summary": weather["info"] as! String,
            "iconString": weather["icon"] as! String,
            "currentTime": weather["dataUptime"] as! String
        ]
    }
}

protocol CurrentViewDelegate: class{

}

