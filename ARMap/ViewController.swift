//
//  ViewController.swift
//  ARMap
//
//  Created by Muhannad Mousa on 9/23/17.
//  Copyright © 2017 Muhannad Mousa. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import CoreLocation

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    struct myCameraCoordinat {
        var x = Float()
        var y = Float()
        var z = Float()
    }
//    func getCameraCoordinate(sceneview: ARSCNView) -> myCameraCoordinate{
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene

//        let arrow = SCNNode(geometry: SCNBox(width: 1, height: 1, length: 1, chamferRadius: 1))
        let arrow = SCNNode(geometry: SCNPyramid(width: 0.5, height: 0.5, length: 0.5))
        arrow.position = SCNVector3(0,0,-3)
        arrow.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
        arrow.geometry!.firstMaterial?.diffuse.contents  = UIColor(red: 255.0 / 255.0, green: 20.0 / 255.0, blue: 147.0 / 255.0, alpha: 1)


        
        let base = SCNNode(geometry: SCNBox(width: 0.3, height: 0.4, length: 0.3, chamferRadius: 0))
        base.position = SCNVector3(0,0.2,-3)
        base.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
        base.geometry!.firstMaterial?.diffuse.contents  = UIColor(red: 255.0 / 255.0, green: 20.0 / 255.0, blue: 147.0 / 255.0, alpha: 1)

        sceneView.scene.rootNode.addChildNode(arrow)
        sceneView.scene.rootNode.addChildNode(base)
        
        // Set the scene to the view
//        sceneView.scene = arrow
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
