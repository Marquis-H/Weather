//
//  LocationViewModel.swift
//  Weather
//
//  Created by marquis on 16/2/1.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation
import CoreLocation

public class LocationViewModel: NSObject, CLLocationManagerDelegate {
    
    weak var delegate: LocationViewDelegate?
    weak var delegateData: WeatherDataDelegate?
    var location: Location = Location()
    var weatherData: WeatherDataService?
    init(delegate: LocationViewDelegate, delegateData: WeatherDataDelegate){
        self.delegate = delegate
        self.delegateData = delegateData
    }
    
    func initLocationManager(){
        location.seenError = false
        location.locationFixAchieved = false
        location.locationManager = CLLocationManager()
        location.locationManager.delegate = self
        location.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        location.locationManager.requestAlwaysAuthorization()
        location.locationManager.startUpdatingLocation()
        location.locationManager.requestWhenInUseAuthorization()
    }
}

//MARK: - locationManager
extension LocationViewModel{
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            self.displayLocationInfo(placemarks![0])
            if self.location.locationFixAchieved == false{
                self.location.locationFixAchieved = true
                let locationArray = locations as NSArray
                self.location.currLocation = locations.last
                let locationObj = locationArray.lastObject as! CLLocation
                let coord = locationObj.coordinate
                self.location.userLatitude = coord.latitude
                self.location.userLongitude = coord.longitude
                //MARK - Get City
                //self.lonLatToCity()
                
                //TODO MARK GET CURRENT WEATHER DATA
                self.weatherData = WeatherDataService(delegate: self.delegateData!, userCity: self.location.userCity!)
                self.weatherData?.getWeatherData()
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark?){
        if let containsPlacemark = placemark{
            //stop updating location
            location.locationManager.stopUpdatingLocation()
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            _ = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            _ = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            location.userCity = locality!.stringByReplacingOccurrencesOfString("市", withString: "")
            
//            print(postalCode)
            delegate?.displayLocationInfo(locality!, administrativeArea: administrativeArea!)
        }
    }
    
    public func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        var shouldIAllow = false
        
        switch status{
        case CLAuthorizationStatus.Restricted:
            location.locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.Denied:
            location.locationStatus = "User denied access to locaton"
        case CLAuthorizationStatus.NotDetermined:
            location.locationStatus = "Status not determined"
        default:
            location.locationStatus = "Allowed to location Access"
            shouldIAllow = true
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
        if shouldIAllow == true{
            NSLog("Location to Allowed")
            location.locationManager.startUpdatingLocation()
        }else{
            NSLog("Denied access: \(location.locationStatus)")
        }
    }
    
    func lonLatToCity(){
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location.currLocation, completionHandler: {(placemarks, error)->Void in
            if error == nil{
                let array = placemarks! as NSArray
                let mark = array.firstObject as! CLPlacemark
                //city
                let city = (mark.addressDictionary! as NSDictionary).valueForKey("City") as! String
                self.location.userCity = city.stringByReplacingOccurrencesOfString("市", withString: "")
                print(city)
                print(self.location.userCity)
            }else{
                NSLog("Error LonLat To City")
            }
        })
    }
}

public protocol LocationViewDelegate: class{
    func displayLocationInfo(locality: String, administrativeArea: String)
}
