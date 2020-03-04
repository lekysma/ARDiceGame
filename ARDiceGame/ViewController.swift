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
        
        // on cree un cube. PS : 1 est 1M dont 0.1 est 10cm et chamferradius est l'arrondi du cube
        let cube = SCNBox(width: 0.12, height: 0.12, length: 0.12, chamferRadius: 0.02)
        // on cree un materiel pour ajouter details au cube
        let material = SCNMaterial()
        // ici on definit la couleur que l'on va donner au cube
        material.diffuse.contents = UIColor.systemBlue
        // on affecte ces details au cube
        cube.materials = [material]
        // enfin on donne une position a ce cube sur un axe horizontal X, vertical Y et proche de soi Z
        let node = SCNNode()
        node.position = SCNVector3(0, 0.25, -0.44)
        
        // on place le cube sur cet axe
        node.geometry = cube
        
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
