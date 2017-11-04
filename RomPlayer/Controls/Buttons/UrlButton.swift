//
//  UrlButton.swift
//  RomPlayer
//
//  Created by Matthew Fecher on 10/5/17.
//  Copyright © 2017 Matthew Fecher. All rights reserved.
//

import UIKit

class UrlButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        clipsToBounds = true
        layer.cornerRadius = 2
        layer.borderWidth = 1
        //        layer.borderColor = #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1) as! CGColor
    }
    
}
