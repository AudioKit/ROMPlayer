//
//  PopUpViewController.swift
//  ROM Player
//
//  Created by Matthew Fecher on 11/27/16.
//  Copyright © 2016 audiokit. All rights reserved.
//

import UIKit

protocol KeySettingsPopOverDelegate {
    func didFinishSelecting(octaveRange: Int, labelMode: Int, darkMode: Bool)
}

class PopUpKeySettingsController: UIViewController {
    
    @IBOutlet weak var octaveRangeSegment: UISegmentedControl!
    @IBOutlet weak var labelModeSegment: UISegmentedControl!
    @IBOutlet weak var keyboardModeSegment: UISegmentedControl!
    @IBOutlet weak var keyboardImage: UIImageView!
    
    var delegate: KeySettingsPopOverDelegate?
    
    var labelMode: Int = 1
    var octaveRange: Int = 2
    var darkMode: Bool = false
    
    enum KeyImage: String {
        case lightMode = "mockup_whitekeys"
        case darkMode = "mockup_blackkeys"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.06666666667, blue: 0.06666666667, alpha: 1)
        view.layer.borderWidth = 2

        // set currently selected options
        octaveRangeSegment.selectedSegmentIndex = octaveRange - 1
        labelModeSegment.selectedSegmentIndex = labelMode
        
        keyboardModeSegment.selectedSegmentIndex = darkMode ? 1 : 0
        if !darkMode {
            keyboardImage.image = UIImage(named: KeyImage.lightMode.rawValue)
        }
    }
    
    // Set fonts for UISegmentedControls
    override func viewDidLayoutSubviews() {
        let attr = NSDictionary(object: UIFont(name: "Avenir Next Condensed", size: 16.0)!, forKey: NSAttributedStringKey.font as NSCopying)
        labelModeSegment.setTitleTextAttributes(attr as [NSObject : AnyObject] , for: .normal)
        keyboardModeSegment.setTitleTextAttributes(attr as [NSObject : AnyObject] , for: .normal)
        octaveRangeSegment.setTitleTextAttributes(attr as [NSObject : AnyObject] , for: .normal)
    }
    
    // **********************************************************
    // MARK: - Actions
    // **********************************************************
    
    @IBAction func octaveRangeDidChange(_ sender: UISegmentedControl) {
        
        octaveRange = sender.selectedSegmentIndex + 1
        delegate?.didFinishSelecting(octaveRange: octaveRange, labelMode: labelMode, darkMode: darkMode)
    }
    
    @IBAction func keyLabelDidChange(_ sender: UISegmentedControl) {
        
           labelMode = sender.selectedSegmentIndex
           delegate?.didFinishSelecting(octaveRange: octaveRange, labelMode: labelMode, darkMode: darkMode)
    }
    
    
    @IBAction func keyboardModeDidChange(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1 {
            darkMode = true
            keyboardImage.image = UIImage(named: KeyImage.darkMode.rawValue)
        } else {
            darkMode = false
            keyboardImage.image = UIImage(named: KeyImage.lightMode.rawValue)
        }
        
        delegate?.didFinishSelecting(octaveRange: octaveRange, labelMode: labelMode, darkMode: darkMode)
    }
    
    
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }


}
