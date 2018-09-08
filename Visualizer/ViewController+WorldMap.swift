//
//  ViewController+WorldMap.swift
//  Visualizer
//
//  Created by Tony Morales on 9/8/18.
//  Copyright © 2018 Tony Morales. All rights reserved.
//

import ARKit

extension ViewController {
    
    func archive(worldMap: ARWorldMap) throws {
        let data = try NSKeyedArchiver.archivedData(withRootObject: worldMap, requiringSecureCoding: true)
        try data.write(to: self.worldMapURL, options: [.atomic])
    }
    
    func unarchive(worldMapData data: Data) -> ARWorldMap? {
        guard let unarchivedWorldMap = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data) else { return nil }
        return unarchivedWorldMap
    }
    
    func retrieveWorldMapData(from url: URL) -> Data? {
        do {
            return try Data(contentsOf: self.worldMapURL)
        } catch {
            print("Error retrieving world map data.")
            return nil
        }
    }
}
