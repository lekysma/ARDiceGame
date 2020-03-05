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
        
        // on va pouvoir visualiser plus facilement la detection d'une surface horizontale
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
//        // on cree une sphere et on lui donne un rayon
//        let sphere = SCNSphere(radius: 0.14)
//        // on cree un materiel pour ajouter details au cube
//        let material = SCNMaterial()
//        // ici on va attacher une image a notre material, image qu'on ajoute a art.scnassets
//        material.diffuse.contents = UIImage(named: "art.scnassets/mars.jpg")
//        // on affecte ces details au cube
//        sphere.materials = [material]
//        // enfin on donne une position a ce cube sur un axe horizontal X, vertical Y et proche de soi Z
//        let node = SCNNode()
//        node.position = SCNVector3(0, 0.25, -0.44)
//
//        // on place le cube sur cet axe
//        node.geometry = sphere
//
//        // enfin on place le node dans la scene qui affiche la figure
//        sceneView.scene.rootNode.addChildNode(node)
        // et on ajoute une luminosite qui rend l'effet 3D plus apparent
        sceneView.autoenablesDefaultLighting = true
        
        // Create a new scene
//        let diceScene = SCNScene(named: "art.scnassets/diceCollada copy.scn")!
//
//        // on cree une scene avec comme identifiant celui de notre dé
//        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
//
//            // on positionne le dé
//            diceNode.position = SCNVector3(0, 0.22, -0.44)
//
//            //enfin on place le node dans la scene qui affiche la figure
//            sceneView.scene.rootNode.addChildNode(diceNode)
//        } else {
//            print("Impossible d'afficher la figure")
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // on donne la possibilité de detecter une surface horizontale
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    //MARK: - Delegate qui permet de detecter une surface horizontale, ID ses dimensions et y placer un objet
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            //succes
            
            // on cree une tuile sur laquelle on va fixer notre figure
            let planeAnchor = anchor as! ARPlaneAnchor
            
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            
            // on cree un node a qui on va donner une position
            let planeNode = SCNNode()
            
            planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
            
            // on transforme ce plan (qui par defaut est vertical) en plan horizontal via la formule suivante
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
            // nous allons utiliser un fichier grille pour  visualiser notre surface plane
            let planeMaterial = SCNMaterial()
            planeMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            // on relie le material a notre surface
            plane.materials = [planeMaterial]
            // on relie notre surface au node
            planeNode.geometry = plane
            //enfin on ajoute un child node : deux ecritures dans ce delegate
            //1. avec parametre node
            node.addChildNode(planeNode)
            //2.version habituelle
            //sceneView.scene.rootNode.addChildNode(planeNode)
            
            print("succes!")
            
        } else {
            // on sort de cette fonction
            return
        }
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
