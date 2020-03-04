//
//  ViewController.swift
//  ARDiceGame
//
//  Created by Jean martin Kyssama on 03/03/2020.
//  Copyright © 2020 Jean martin Kyssama. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // on cree une sphere et on lui donne un rayon
        let sphere = SCNSphere(radius: 0.14)
        // on cree un materiel pour ajouter details au cube
        let material = SCNMaterial()
        // ici on va attacher une image a notre material, image qu'on ajoute a art.scnassets
        material.diffuse.contents = UIImage(named: "art.scnassets/mars.jpg")
        // on affecte ces details au cube
        sphere.materials = [material]
        // enfin on donne une position a ce cube sur un axe horizontal X, vertical Y et proche de soi Z
        let node = SCNNode()
        node.position = SCNVector3(0, 0.25, -0.44)
        
        // on place le cube sur cet axe
        node.geometry = sphere
        
        // enfin on place le node dans la scene qui affiche la figure
        sceneView.scene.rootNode.addChildNode(node)
        // et on ajoute une luminosite qui rend l'effet 3D plus apparent
        sceneView.autoenablesDefaultLighting = true
        
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
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

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    

}
