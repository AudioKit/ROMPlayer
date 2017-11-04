//
//  PopUpMIDIController.swift
//  RomPlayer
//
//  Created by Matthew Fecher on 10/22/17.
//  Copyright © 2017 Matthew Fecher. All rights reserved.
//

import UIKit

protocol MIDISettingsPopOverDelegate {
    func resetMIDILearn()
    func didSelectMIDIChannel(newChannel: Int)
}

class PopUpMIDIController: UIViewController {

    @IBOutlet weak var channelStepper: Stepper!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var resetButton: SynthUIButton!
    
    var delegate: MIDISettingsPopOverDelegate?
    
    var userChannelIn: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.borderColor = #colorLiteral(red: 0.06666666667, green: 0.06666666667, blue: 0.06666666667, alpha: 1)
        view.layer.borderWidth = 2
        
        // setup channel stepper
        userChannelIn += 1 // Internal MIDI Channels start at 0...15, Users see 1...16
        channelStepper.maxValue = 16
        channelStepper.value = userChannelIn
        updateChannelLabel()
        
        // Setup Callbacks
        setupCallbacks()
    }
    
    
    // **********************************************************
    // MARK: - Callbacks
    // **********************************************************
    
    func setupCallbacks() {
        // Setup Callback
        channelStepper.callback = { value in
            self.userChannelIn = Int(value)
            self.updateChannelLabel()
            self.delegate?.didSelectMIDIChannel(newChannel: self.userChannelIn - 1)
        }
        
        resetButton.callback = { value in
            self.delegate?.resetMIDILearn()
            self.resetButton.value = 0
            self.displayAlertController("MIDI Learn Reset", message: "All MIDI learn knob assignments have been removed.")
        }
    }
    
    func updateChannelLabel() {
        if userChannelIn == 0 {
            self.channelLabel.text = "MIDI Channel In: Omni"
        } else {
            self.channelLabel.text = "MIDI Channel In: \(userChannelIn)"
        }
    }

    // **********************************************************
    // MARK: - Actions
    // **********************************************************
    
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
