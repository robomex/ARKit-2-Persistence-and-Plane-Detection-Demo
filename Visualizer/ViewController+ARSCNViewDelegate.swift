//
//  ViewController+ARSCNViewDelegate.swift
//  Visualizer
//
//  Created by Tony Morales on 8/25/18.
//  Copyright © 2018 Tony Morales. All rights reserved.
//

import ARKit

extension ViewController: ARSCNViewDelegate {
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        let occlusionPlane = SCNPlane(width: width, height: height)
        plane.firstMaterial?.diffuse.contents = UIColor.blue.withAlphaComponent(0.5)
        occlusionPlane.firstMaterial?.colorBufferWriteMask = []
        
        let planeNode = SCNNode(geometry: plane)
        let occlusionNode = SCNNode(geometry: occlusionPlane)
        
        planeNode.position = SCNVector3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
        planeNode.eulerAngles.x = -.pi / 2
        
        occlusionNode.position = planeNode.position
        occlusionNode.eulerAngles = planeNode.eulerAngles
        occlusionNode.position.y += Constants.occlusionPlaneVerticalOffset
        occlusionNode.renderingOrder = -1
        
        node.addChildNode(planeNode)
        node.addChildNode(occlusionNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane,
            let occlusionNode = node.childNodes.last,
            let occlusionPlane = occlusionNode.geometry as? SCNPlane
            else { return }
        
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        occlusionPlane.width = width
        occlusionPlane.height = height
        
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
        occlusionNode.position = SCNVector3(x, y + CGFloat(Constants.occlusionPlaneVerticalOffset), z)
    }
    
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
