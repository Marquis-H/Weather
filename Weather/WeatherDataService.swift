//
//  WeatherDataService.swift
//  Weather
//
//  Created by marquis on 16/2/2.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation

public class WeatherDataService {
    
    var location: Location = Location()
    var baseURL = NSString(string: weatherApi)
    let forecastURL: NSURL?
    let sharedSession: NSURLSession?
    
    weak var delegate: WeatherDataDelegate?
    
    init (delegate: WeatherDataDelegate, userCity: String){
        self.delegate = delegate
        self.forecastURL = NSURL(string: (baseURL as String)+"\(userCity.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)")
        self.sharedSession = NSURLSession.sharedSession()
    }
    
}

//MARK - Get Data
extension WeatherDataService{
    func getWeatherData() -> Void{
        let downloadTask: NSURLSessionDownloadTask = self.sharedSession!.downloadTaskWithURL(self.forecastURL!, completionHandler: {
            (location: NSURL?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if(error == nil){
                let dataObject = NSData(contentsOfURL: location!)
                let weatherDictionary: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(dataObject!, options: [])) as! NSDictionary
                let currentWeather = CurrentViewModel(weatherDictionary: weatherDictionary)
                let weeklyWeather = WeatherViewModel(weatherDictionary: weatherDictionary)
                let alertWeather = WeatherAlertsView(weatherDictionary: weatherDictionary)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.show(currentWeather, weeklyWeather: weeklyWeather, alertWeather: alertWeather)
                })
            }else{
                print("Error")
            }
        })
        downloadTask.resume()
    }
}

protocol WeatherDataDelegate: class{
    func show(currentWeather: CurrentViewModel, weeklyWeather: WeatherViewModel, alertWeather: WeatherAlertsView)
}
