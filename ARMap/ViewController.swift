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
    
    struct myCameraCoordinate {
        var x = Float()
        var y = Float()
        var z = Float()
    }
    
    
    
    
    func getCameraCoordinate(sceneview: ARSCNView) -> myCameraCoordinate{
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!)
        
        var cc = myCameraCoordinate()
        cc.x = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.z = cameraCoordinates.translation.z
        
        return cc
    }
    
    
    @objc func buttonAction(sender: UIButton!) {
        let alert = UIAlertController(title: "Alert", message: "location added", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

        
        let arrow = SCNNode(geometry: SCNPyramid(width: 0.5, height: 0.5, length: 0.5))
        let cc  = getCameraCoordinate(sceneview: sceneView)
        arrow.position = SCNVector3(cc.x,cc.y+0.7,cc.z-0.1)
        arrow.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
        arrow.geometry!.firstMaterial?.diffuse.contents  = UIColor(red: 255.0 / 255.0, green: 20.0 / 255.0, blue: 147.0 / 255.0, alpha: 0.8)
        
        
        let base = SCNNode(geometry: SCNBox(width: 0.3, height: 0.4, length: 0.3, chamferRadius: 0))
        base.position = SCNVector3(cc.x,cc.y+1.05,cc.z-0.1)
        base.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
        base.geometry!.firstMaterial?.diffuse.contents  = UIColor(red: 255.0 / 255.0, green: 20.0 / 255.0, blue: 147.0 / 255.0, alpha: 0.8)
        
        let base2 = SCNNode(geometry: SCNBox(width: 0.3, height: 0.1, length: 0.3, chamferRadius: 0))
        base2.position = SCNVector3(cc.x,cc.y+.0775,cc.z-0.1)
        base2.pivot = SCNMatrix4MakeRotation(3.14,1,0,0)
        base2.geometry!.firstMaterial?.diffuse.contents  = UIColor(red: 255.0 / 255.0, green: 20.0 / 255.0, blue: 147.0 / 255.0, alpha: 0.8)
        
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


        
        let button = UIButton(frame: CGRect(x: self.view.frame.width/2 - 50, y: self.view.frame.height - 100, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        


        
        // Create a new scene
//        let arrow = SCNNode(geometry: SCNBox(width: 1, height: 1, length: 1, chamferRadius: 1))
        // Set the scene to the view
  
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
