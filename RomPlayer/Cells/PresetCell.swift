//
//  CategoryCell.swift
//  RomPlayer
//
//  Created by Matthew Fecher on 9/2/17.
//  Copyright © 2017 AudioKit Pro. All rights reserved.
//

import UIKit

class PresetCell: UITableViewCell {
    
    // *********************************************************
    // MARK: - Properties / Outlets
    // *********************************************************
    
    @IBOutlet weak var presetLabel: UILabel!
    
    // *********************************************************
    // MARK: - Lifecycle
    // *********************************************************
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // set cell selection color
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView  = selectedView
        
        presetLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        // let color = editButton.backgroundColor
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        if selected {
            presetLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.262745098, alpha: 1)
        } else {
             presetLabel?.textColor = #colorLiteral(red: 0.7333333333, green: 0.7333333333, blue: 0.7333333333, alpha: 1)
             backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
 
    
    // *********************************************************
    // MARK: - Configure Cell
    // *********************************************************
    
    func configureCell(presetName: String) {
        presetLabel.text = "\(presetName)"
    }
    
}
