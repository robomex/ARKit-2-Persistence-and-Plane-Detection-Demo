//
//  ViewController.swift
//  Visualizer
//
//  Created by Tony Morales on 8/25/18.
//  Copyright © 2018 Tony Morales. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var worldMapURL: URL = {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("worldMapURL")
        } catch {
            fatalError("Error getting world map URL from document directory.")
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTrackingConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func resetTrackingConfiguration(with worldMap: ARWorldMap? = nil) {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        
        if let worldMap = worldMap {
            configuration.initialWorldMap = worldMap
        }
        
        sceneView.session.run(configuration, options: options)
    }
    
    // MARK: Button Actions
    
    @objc func saveButtonTapped(_ sender: Any) {
        sceneView.session.getCurrentWorldMap { (worldMap, error) in
            guard let worldMap = worldMap else {
                print("Error getting current world map.")
                return
            }
            
            do {
                try self.archive(worldMap: worldMap)
                DispatchQueue.main.async {
                    print("World Map is saved.")
                }
            } catch {
                fatalError("Error saving world map: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func resetButtonTapped(_ sender: Any) {
        if let worldMapData = retrieveWorldMapData(from: worldMapURL) {
            let worldMap = unarchive(worldMapData: worldMapData)
            resetTrackingConfiguration(with: worldMap)
        } else {
            resetTrackingConfiguration()
        }
    }
}
