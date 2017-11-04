//
//  SynthUIButton.swift
//  AudioKitSynthOne
//
//  Created by Matthew Fecher on 8/8/17.
//  Copyright © 2017 AudioKit. All rights reserved.
//

import UIKit

public class SynthUIButton: UIButton {
    
    var callback: (Double)->Void = { _ in }
    
    var isOn: Bool {
        return value == 1
    }
    
    override public var isSelected: Bool {
        didSet {
            self.backgroundColor = isOn ? #colorLiteral(red: 0.431372549, green: 0.431372549, blue: 0.4509803922, alpha: 1) : #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2823529412, alpha: 1)
            setNeedsDisplay()
        }
    }
    
    var value: Double = 0.0 {
        didSet {
            isSelected = value == 1.0
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        clipsToBounds = true
        layer.cornerRadius = 2
        layer.borderWidth = 1
        //        layer.borderColor = #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1) as! CGColor
    }
    
    // *********************************************************
    // MARK: - Handle Touches
    // *********************************************************
    
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            value = isOn ? 0 : 1
            self.setNeedsDisplay()
            callback(value)
        }
    }
    
}

