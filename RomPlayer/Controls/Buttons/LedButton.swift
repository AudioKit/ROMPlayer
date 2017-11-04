//
//  LedButton.swift
//  RomPlayer
//
//  Created by Matthew Fecher on 9/19/17.
//  Copyright © 2017 AudioKit Pro. All rights reserved.
//


import UIKit

@IBDesignable
class LedButton: ToggleButton {
    
    public override func draw(_ rect: CGRect) {
        LedToggleStyleKit.drawLedButton(isToggled: isOn)
    }
    
}

