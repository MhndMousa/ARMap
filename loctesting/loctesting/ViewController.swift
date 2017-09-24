//
//  ViewController.swift
//  loctesting
//
//  Created by Kristiāns Kanders on 9/23/17.
//  Copyright © 2017 Kristians Kanders. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var long: UILabel!
    @IBOutlet weak var lat: UILabel!
    
    var locationManager: CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
      
        locationManager.startUpdatingLocation()
        scheduledTimerWithTimeInterval()
        // view.backgroundColor = UIColor.blue
    }

    @IBOutlet weak var count: UILabel!
    var timer = Timer()
    var counter = 0
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.ggggggg), userInfo: nil, repeats: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        if status == .authorizedWhenInUse{
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
                    let currentLocation = locationManager.location
                    long.text = String(describing: currentLocation?.coordinate.longitude)
                    lat.text = String(describing: currentLocation?.coordinate.latitude)
                    counter += 1
                    count.text = String(describing: counter)
                }
            }
        }
    }
    @IBOutlet weak var y: UILabel!
    @objc func ggggggg(){
        let currentLocation = locationManager.location
        long.text = String(locationOnEarth(lat:42.292005,long: -83.716203, currentLatitude: (currentLocation?.coordinate.latitude)!, currentLongitude: (currentLocation?.coordinate.longitude)!).x)
//        var x = currentLocation?.coordinate.latitude
//         long.text = String(describing: x)
//         lat.text = String(describing: currentLocation?.coordinate.longitude)
        lat.text = String(locationOnEarth(lat:42.292005,long: -83.716203, currentLatitude: (currentLocation?.coordinate.latitude)!, currentLongitude: (currentLocation?.coordinate.longitude)!).z)
        
        y.text = String(locationOnEarth(lat:42.292005,long: -83.716203, currentLatitude: (currentLocation?.coordinate.latitude)!, currentLongitude: (currentLocation?.coordinate.longitude)!).y)
        counter += 1
        count.text = String(describing: counter)
    }
    struct coordinate{
        var x = Double()
        var y = Double()
        var z = Double()
    }
    func locationOnEarth( lat:Double, long:Double, currentLatitude:Double, currentLongitude:Double) -> coordinate{
        
        let lat = 42.292005
        let long = -83.716203

        // let xOfInput = 2 * 6371000.0 * cos(lat) * cos(long)
        let yOfInput = 6371000.0 * cos(lat) * sin(long)
        // let zOfInput = 2 * 6371000.0 * sin(lat)

        let currentLong = currentLongitude
        let currentLat = currentLatitude

        // let xOfCurrent = 2 * 6371000.0 * cos(currentLat) * cos(currentLong)
        let yOfCurrent = 6371000.0 * cos(currentLat) * sin(currentLong)
        // let zOfCurrent = 2 * 6371000.0 * sin(currentLat)

        let xFromCurrentToInput = 2 * 6371000.0 * ((lat - currentLat)/360)
        let zFromCurrentToInput = 2 * 6371000.0 * ((long - currentLong)/360)
        let yFromCurrentToInput = yOfInput - yOfCurrent

        var loc = coordinate()
        loc.z = zFromCurrentToInput
        loc.y = yFromCurrentToInput
        loc.x = xFromCurrentToInput
        return loc
        
    }
}


