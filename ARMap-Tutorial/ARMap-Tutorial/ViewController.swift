//
//  ViewController.swift
//  ARMap-Tutorial
//
//  Created by Muhannad Mousa on 1/31/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    struct coordinate {
        var x = Double()
        var y = Double()
        var z = Double()
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
        let cc = getCameraCoordinate(sceneview: sceneView)
        arrow.position = SCNVector3(cc.x,cc.y+0.7,cc.z-0.1)
        arrow.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
        arrow.geometry!.firstMaterial?.diffuse.contents = pink
        
        let base = SCNNode(geometry: SCNBox(width: 0.3, height: 0.4, length: 0.3, chamferRadius: 0))
        base.position = SCNVector3(cc.x,cc.y+1.05,cc.z-0.1)
        base.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
        base.geometry!.firstMaterial?.diffuse.contents = pink
        
        let base2 = SCNNode(geometry: SCNBox(width: 0.3, height: 0.1, length: 0.3, chamferRadius: 0))
        base2.position = SCNVector3(cc.x,cc.y+0.0775,cc.z-0.1)
        base2.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
        base2.geometry!.firstMaterial?.diffuse.contents = pink
        
        
        
        sceneView.scene.rootNode.addChildNode(arrow)
        sceneView.scene.rootNode.addChildNode(base)
        sceneView.scene.rootNode.addChildNode(base2)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Add current location button to super view
        let button = UIButton(frame: CGRect(x: self.view.frame.width - 100, y: self.view.frame.height - 100, width: 100, height: 50))
        button.backgroundColor = .blue
        button.setTitle("Current Location", for: .normal)
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(addCurrentLocation(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
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
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

