//
//  UIButtonExtension.swift
//  Fate Twist
//
//  Created by Eduard Caziuc on 30/06/2018.
//  Copyright © 2018 Eduard Caziuc. All rights reserved.
//

import UIKit

extension UIButton {
    
    func wiggle() {
        let wiggleAnimation = CABasicAnimation(keyPath: "position")
        wiggleAnimation.duration = 0.05
        wiggleAnimation.repeatCount = 3
        wiggleAnimation.autoreverses = true
        wiggleAnimation.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y - 1.0)
        wiggleAnimation.toValue = CGPoint(x: self.center.x + 4.0, y: self.center.y + 1.0)
        layer.add(wiggleAnimation, forKey: "position")
    }
}
