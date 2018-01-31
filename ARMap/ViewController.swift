//
// ViewContoller.swift
//  ARMap
//
//  Created by Muhannad Mousa on 9/23/17.
//  Copyright © 2017 Muhannad Mousa. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import MapKit
import CoreLocation
import Foundation


class ViewController: UIViewController, ARSCNViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var long: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet var sceneView: ARSCNView!
    var timer = Timer()
    var counter = 0
    var locationManager: CLLocationManager!
    var updateInfoLabelTimer: Timer?
    
    struct coordinate {
        var x = Double()
        var y = Double()
        var z = Double()
    }
    
    
    
    
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCoordinates), userInfo: nil, repeats: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        if status == .authorizedWhenInUse{
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
//                    let currentLocation = locationManager.location
//                    long.text = String(describing: currentLocation?.coordinate.longitude)
//                    lat.text = String(describing: currentLocation?.coordinate.latitude)
//                    counter += 1
//                    count.text = String(describing: counter)
                }
            }
        }
    }
    
   // Uses Map
    @objc func updateCoordinates(){
//        let currentLocation = locationManager.location
//        long.text = String(describing: currentLocation?.coordinate.longitude)
//        lat.text = String(describing: currentLocation?.coordinate.longitude)
//        counter += 1
//        print(counter)
//        count.text = String(describing: counter)
    }
    
    // Uses AR
    func getCameraCoordinate(sceneview: ARSCNView) -> coordinate{
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!)
        
        var cc = coordinate()
        cc.x = Double(cameraCoordinates.translation.x)
        cc.y = Double(cameraCoordinates.translation.y)
        cc.z = Double(cameraCoordinates.translation.z)
        
        return cc
    }
    
    
    @objc func addCurrentLocation(sender: UIButton!) {
        let alert = UIAlertController(title: "Marked", message: "Your location has been added to the map", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        let pink = UIColor(red: 255.0 / 255.0, green: 20.0 / 255.0, blue: 147.0 / 255.0, alpha: 0.8)
        
        let arrow = SCNNode(geometry: SCNPyramid(width: 0.5, height: 0.5, length: 0.5))
        let cc  = getCameraCoordinate(sceneview: sceneView)
        arrow.position = SCNVector3(cc.x,cc.y+0.7,cc.z-0.1)
        arrow.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
      	  arrow.geometry!.firstMaterial?.diffuse.contents  = pink
        
        let base = SCNNode(geometry: SCNBox(width: 0.3, height: 0.4, length: 0.3, chamferRadius: 0))
        base.position = SCNVector3(cc.x,cc.y+1.05,cc.z-0.1)
        base.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
        base.geometry!.firstMaterial?.diffuse.contents  = pink
        
        let base2 = SCNNode(geometry: SCNBox(width: 0.3, height: 0.1, length: 0.3, chamferRadius: 0))
        base2.position = SCNVector3(cc.x,cc.y+0.0775,cc.z-0.1)
        base2.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
        base2.geometry!.firstMaterial?.diffuse.contents  = pink
        
        sceneView.scene.rootNode.addChildNode(arrow)
        sceneView.scene.rootNode.addChildNode(base)
        sceneView.scene.rootNode.addChildNode(base2)
    }
    
    
    @objc func addFriendLocation(sender: UIButton!) {
            
            let alert = UIAlertController(title: "Marked", message: "Your friend's location has been added to the map", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            let green = UIColor.green
            
            let arrow = SCNNode(geometry: SCNPyramid(width: 0.5, height: 0.5, length: 0.5))
            let cc  = getCameraCoordinate(sceneview: sceneView)
            arrow.position = SCNVector3(cc.x+10,cc.y+0.7,cc.z-0.1)
            arrow.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
            arrow.geometry!.firstMaterial?.diffuse.contents  = green
            let base = SCNNode(geometry: SCNBox(width: 0.3, height: 0.4, length: 0.3, chamferRadius: 0))
            base.position = SCNVector3(cc.x+10,cc.y+1.05,cc.z-0.1)
            base.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
            base.geometry!.firstMaterial?.diffuse.contents  = green
            
            let base2 = SCNNode(geometry: SCNBox(width: 0.3, height: 0.1, length: 0.3, chamferRadius: 0))
            base2.position = SCNVector3(cc.x+10,cc.y+0.0775,cc.z-0.1)
            base2.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
            base2.geometry!.firstMaterial?.diffuse.contents  = green
            
            sceneView.scene.rootNode.addChildNode(arrow)
            sceneView.scene.rootNode.addChildNode(base)
            sceneView.scene.rootNode.addChildNode(base2)
            
        
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        scheduledTimerWithTimeInterval()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true

        
        
//        let coordinate = CLLocationCoordinate2D(latitude: 51.504571, longitude: -0.019717)
//        let location = CLLocation(latitude: -83.716203, longitude: 42.292005)
//        let image = UIImage(named: "pin.png")!
//        let annotationNode = LocationAnnotationNode(location: location, image: image)
//        addLocationNodeWithConfirmedLocation(locationNode: annotationNode)

//        let loc = locationOnEarth(lat: 42.292005, long: -83.716203)
        //        var x = currentLocation?.coordinate.latitude
        //         long.text = String(describing: x)
        //         lat.text = String(describing: currentLocation?.coordinate.longitude)
//        let currentLocation = locationManager.location
//
//        let z_coordinate = locationOnEarth(lat:42.292005,long: -83.716203, currentLatitude: (currentLocation?.coordinate.latitude)!, currentLongitude: (currentLocation?.coordinate.longitude)!).z
//        let x_coordinate = locationOnEarth(lat:42.292005,long: -83.716203, currentLatitude: (currentLocation?.coordinate.latitude)!, currentLongitude: (currentLocation?.coordinate.longitude)!).x
//
//        var y = locationOnEarth(lat:42.292005,long: -83.716203, currentLatitude: (currentLocation?.coordinate.latitude)!, currentLongitude: (currentLocation?.coordinate.longitude)!).y
//
//
//
//        let arrow = SCNNode(geometry: SCNPyramid(width: 0.5, height: 0.5, length: 0.5))
//        arrow.position = SCNVector3(x_coordinate,0,z_coordinate)
//        arrow.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
//        arrow.geometry!.firstMaterial?.diffuse.contents  = UIColor(red: 255.0 / 255.0, green: 20.0 / 255.0, blue: 147.0 / 255.0, alpha: 0.8)
//        sceneView.scene.rootNode.addChildNode(arrow)
//
        let button = UIButton(frame: CGRect(x: self.view.frame.width - 100, y: self.view.frame.height - 100, width: 100, height: 50))
        button.backgroundColor = .blue
        button.setTitle("Current Location", for: .normal)
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(addCurrentLocation(sender:)), for: .touchUpInside)

        let button2 = UIButton(frame: CGRect(x: 0, y: self.view.frame.height - 100, width: 100, height: 50))
        button2.backgroundColor = .blue
        button2.setTitle("Friend Location", for: .normal)
        button2.titleLabel!.font = UIFont.boldSystemFont(ofSize: 12)
        button2.addTarget(self, action: #selector(addFriendLocation(sender:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        self.view.addSubview(button2)
    
        
    }

    func locationOnEarth( lat:Double, long:Double, currentLatitude:Double, currentLongitude:Double) -> coordinate{
        
        let lat = 42.292005
        let long = -83.716203
        
         let xOfInput = 6371000.0 * cos(lat) * cos(long)
        let yOfInput = 6371000.0 * cos(lat) * sin(long)
         let zOfInput = 6371000.0 * sin(lat)
        
        let currentLong = currentLongitude
        let currentLat = currentLatitude
        
         let xOfCurrent = 6371000.0 * cos(currentLat) * cos(currentLong)
        let yOfCurrent = 6371000.0 * cos(currentLat) * sin(currentLong)
         let zOfCurrent =  6371000.0 * sin(currentLat)
        
        let xFromCurrentToInput = xOfInput - xOfCurrent
        let zFromCurrentToInput = zOfInput - zOfCurrent
        let yFromCurrentToInput = yOfInput - yOfCurrent
        
        var loc = coordinate()
        loc.z = zFromCurrentToInput
        loc.y = yFromCurrentToInput
        loc.x = xFromCurrentToInput
        return loc
        
    }
    
//    func locationOnEarth( lat:Double, long:Double) -> coordinate{
//
//        let lat = lat
//        let long = long
//
//        let xOfInput = 6371000.0 * cos(lat) * cos(long)
//        let yOfInput = 6371000.0 * cos(lat) * sin(long)
//        let zOfInput = 6371000.0 * sin(lat)
//
//        let currentLocation = locationManager.location
//
//        let currentLong = currentLocation?.coordinate.longitude
//        let currentLat = currentLocation?.coordinate.latitude
//
//        let xOfCurrent = 6371000.0 * cos(currentLat!) * cos(currentLong!)
//        let yOfCurrent = 6371000.0 * cos(currentLat!) * sin(currentLong!)
//        let zOfCurrent = 6371000.0 * sin(currentLat!)
//
//        let xFromCurrentToInput = xOfInput - xOfCurrent
//        let zFromCurrentToInput = zOfInput - zOfCurrent
//        let yFromCurrentToInput = yOfInput - yOfCurrent
//
//        var loc = coordinate()
//        loc.z = Float(zFromCurrentToInput)
//        loc.y = Float(yFromCurrentToInput)
//        loc.x = Float(xFromCurrentToInput)
//        return loc
//
//    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}


