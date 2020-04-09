//
//  UIButtonExtension.swift
//  Practice_Training
//
//  Created by Dominique Michael Abejar on 4/9/20.
//  Copyright © 2020 BootCampSwift. All rights reserved.
//

import Foundation
import UIKit


extension UIButton {
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        
        pulse.duration = 0.45
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.initialVelocity = 2
        pulse.damping = 0.5
        
        layer.add(pulse, forKey: nil)
    }
}
