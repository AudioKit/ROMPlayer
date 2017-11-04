//
//  FlatKnob.swift
//  RomPlayer
//
//  Created by Matthew Fecher on 9/19/17.
//  Copyright © 2017 AudioKit Pro. All rights reserved.
//


import UIKit

@IBDesignable
public class FlatKnob: Knob {
    
    public override func draw(_ rect: CGRect) {
        FlatKnobStyleKit.drawFlatKnob(frame: CGRect(x:0,y:0, width: self.bounds.width, height: self.bounds.height), knobValue: knobValue)
    }
    
}
