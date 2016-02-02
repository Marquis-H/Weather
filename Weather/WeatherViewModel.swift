//
//  CurrentViewModel.swift
//  Weather
//
//  Created by Marquis on 16/1/30.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation
import UIKit

public class WeatherViewModel {
    
    weak var delegate: WearherViewDelegete?
    var weekly: Weekly = Weekly()
    //Mark: - Initialization
    init(weatherDictionary: NSDictionary){
        self.initData(weatherDictionary)
    }
    
    func initData(weatherDictionary: NSDictionary){
        let weather = weatherDictionary["weather"] as! NSArray
        //Day Current
        let correntInfo = weather[0]["info"] as! NSDictionary
        let correntDayInfo = correntInfo["day"] as! NSArray
        let correntNightInfo = correntInfo["night"] as! NSArray
        weekly.dayCurrentTemperatureMax = (correntDayInfo[2] as! Int)
        weekly.dayCurrentTemperatureMin = (correntNightInfo[2] as! Int)
        
        //Day One
        let dayOneInfo = weather[1]["info"] as! NSDictionary
        let oneDayInfo = dayOneInfo["day"] as! NSArray
        let oneNightInfo = dayOneInfo["night"] as! NSArray
        weekly.dayOneTemperatureMax = (oneDayInfo[2] as! Int)
        weekly.dayOneTemperatureMin = (oneNightInfo[2] as! Int)
        weekly.dayOneTime = (weather[1]["week"] as! String)
        weekly.dayOneIcon = self.weatherIconFromString(oneDayInfo[0] as! String)
        
        //Day Two
        let dayTwoInfo = weather[2]["info"] as! NSDictionary
        let twoDayInfo = dayTwoInfo["day"] as! NSArray
        let twoNightInfo = dayTwoInfo["night"] as! NSArray
        weekly.dayTwoTemperatureMax = (twoDayInfo[2] as! Int)
        weekly.dayTwoTemperatureMin = (twoNightInfo[2] as! Int)
        weekly.dayTwoTime = (weather[2]["week"] as! String)
        weekly.dayTwoIcon = self.weatherIconFromString(twoDayInfo[0] as! String)
        
        //Day Three
        let dayThreeInfo = weather[3]["info"] as! NSDictionary
        let threeDayInfo = dayThreeInfo["day"] as! NSArray
        let threeNightInfo = dayThreeInfo["night"] as! NSArray
        weekly.dayThreeTemperatureMax = (threeDayInfo[2] as! Int)
        weekly.dayThreeTemperatureMin = (threeNightInfo[2] as! Int)
        weekly.dayThreeTime = (weather[3]["week"] as! String)
        weekly.dayThreeIcon = self.weatherIconFromString(threeDayInfo[0] as! String)
        
        //Day Four
        let dayFourInfo = weather[4]["info"] as! NSDictionary
        let fourDayInfo = dayFourInfo["day"] as! NSArray
        let fourNightInfo = dayFourInfo["night"] as! NSArray
        weekly.dayFourTemperatureMax = (fourDayInfo[2] as! Int)
        weekly.dayFourTemperatureMin = (fourNightInfo[2] as! Int)
        weekly.dayFourTime = (weather[4]["week"] as! String)
        weekly.dayFourIcon = self.weatherIconFromString(fourDayInfo[0] as! String)
        
        //Day Five
        let dayFiveInfo = weather[5]["info"] as! NSDictionary
        let fiveDayInfo = dayFiveInfo["day"] as! NSArray
        let fiveNightInfo = dayFiveInfo["night"] as! NSArray
        weekly.dayFiveTemperatureMax = (fiveDayInfo[2] as! Int)
        weekly.dayFiveTemperatureMin = (fiveNightInfo[2] as! Int)
        weekly.dayFiveTime = (weather[5]["week"] as! String)
        weekly.dayFiveIcon = self.weatherIconFromString(fiveDayInfo[0] as! String)
        
        //Day Six
        let daySixInfo = weather[6]["info"] as! NSDictionary
        let sixDayInfo = daySixInfo["day"] as! NSArray
        let sixNightInfo = daySixInfo["night"] as! NSArray
        weekly.daySixTemperatureMax = (sixDayInfo[2] as! Int)
        weekly.daySixTemperatureMin = (sixNightInfo[2] as! Int)
        weekly.daySixTime = (weather[6]["week"] as! String)
        weekly.daySixIcon = self.weatherIconFromString(sixDayInfo[0] as! String)
    }
}

//MARK: - Image
extension WeatherViewModel{
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

protocol WearherViewDelegete: class{
    
}