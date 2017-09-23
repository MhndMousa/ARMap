//
//  ViewController.swift
//  loctesting
//
//  Created by Kristiāns Kanders on 9/23/17.
//  Copyright © 2017 Kristians Kanders. All rights reserved.
//

import UIKit
import CoreLocation

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
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.ggggggg), userInfo: nil, repeats: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        if status == .authorizedWhenInUse{
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
                    let currentLocation = locationManager.location
                    long.text = String(describing: currentLocation?.coordinate.longitude)
                    lat.text = String(describing: currentLocation?.coordinate.longitude)
                    counter += 1
                    count.text = String(describing: counter)
                }
            }
        }
    }
    @objc func ggggggg(){
        let currentLocation = locationManager.location
        long.text = String(describing: currentLocation?.coordinate.longitude)
        lat.text = String(describing: currentLocation?.coordinate.longitude)
        counter += 1
        count.text = String(describing: counter)
    }
}

