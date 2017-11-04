//
//  RadioButton.swift
//  RomPlayer
//
//  Created by Matthew Fecher on 7/26/17.
//  Copyright © 2017 AudioKit Pro. All rights reserved.
//

import UIKit

class RadioButton: UIButton {
    var alternateButton:Array<RadioButton>?
    
    var callback: (Double)->Void = { _ in }
    
    var value: Double = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? #colorLiteral(red: 0.3058823529, green: 0.3058823529, blue: 0.3254901961, alpha: 1) : #colorLiteral(red: 0.2, green: 0.2, blue: 0.2196078431, alpha: 1)
            value = isSelected ? 1.0 : 0
        }
    }
    
    override func awakeFromNib() {
        layer.cornerRadius = 14
        layer.borderWidth = 2.0
        layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.06666666667, blue: 0.06666666667, alpha: 1)
        layer.masksToBounds = true
    }
    
    func unselectAlternateButtons() {
        if let alternateButton = alternateButton {
            alternateButton.forEach {
                if $0 != self {
                    $0.isSelected = false
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
        self.isSelected = !isSelected
        callback(value)
    }
 
}
