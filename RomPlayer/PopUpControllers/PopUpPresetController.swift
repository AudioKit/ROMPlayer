//
//  PopUpPresetController
//  ROM Player
//
//  Created by Matthew Fecher on 9/5/17.
//  Copyright © 2017 AudioKit Pro. All rights reserved.
//

import UIKit

protocol PresetPopOverDelegate {
    func didSelectNewPreset(presetIndex: Int)
}

class PopUpPresetController: UIViewController {
    @IBOutlet weak var presetsTableView: UITableView!
    @IBOutlet weak var popupView: UIView!
    
    var delegate: PresetPopOverDelegate?
    
    var presets: [String] = []
    var presetIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // presetsTableView.reloadData()
        presetsTableView.separatorColor = #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
        popupView.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        popupView.layer.borderWidth = 2
        popupView.layer.cornerRadius = 3
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Populate Preset current values
        let indexPath = IndexPath(row: presetIndex, section: 0)
        presetsTableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
    }
    
}

// *****************************************************************
// MARK: - TableViewDataSource
// *****************************************************************

extension PopUpPresetController: UITableViewDataSource {
    
    func numberOfSections(in categoryTableView: UITableView) -> Int {
        return 1
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presets.isEmpty {
            return 1
        } else {
            return presets.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PresetCell") as? PresetCell {
            
            // Cell updated in PresetCell.swift
            cell.configureCell(presetName: presets[indexPath.row])
            return cell
            
        } else {
            return PresetCell()
        }
    }
}

//*****************************************************************
// MARK: - TableViewDelegate
//*****************************************************************

extension PopUpPresetController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presetIndex = (indexPath as NSIndexPath).row
        delegate?.didSelectNewPreset(presetIndex: presetIndex)
    }
    
}


