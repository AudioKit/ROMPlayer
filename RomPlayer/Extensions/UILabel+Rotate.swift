//
//  UILabel+Rotate.swift
//  FMPlayer
//
//  Created by Matthew Fecher on 6/12/18.
//  Copyright © 2018 AudioKit Pro. All rights reserved.
//

import UIKit

@IBDesignable
class RotatableLabel: UILabel {
}

extension UILabel {
    @IBInspectable
    var rotation: Int {
        get {
            return 0
        } set {
            let radians = ((CGFloat.pi) * CGFloat(newValue) / CGFloat(180.0))
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
}
