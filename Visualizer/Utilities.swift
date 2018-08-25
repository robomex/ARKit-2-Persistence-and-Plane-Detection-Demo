//
//  Utilities.swift
//  Visualizer
//
//  Created by Tony Morales on 8/25/18.
//  Copyright © 2018 Tony Morales. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random(withAlpha alpha: CGFloat) -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: alpha)
    }
}
