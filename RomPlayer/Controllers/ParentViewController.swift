//
//  ParentViewController.swift
//  ROM Player
//
//  Created by Matthew Fecher on 9/24/17.
//  Copyright © 2017 AudioKit Pro. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI
import GameplayKit

class ParentViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var keyboardView: SynthKeyboard!
    @IBOutlet weak var diceButton: UIButton!
    @IBOutlet weak var monoToggle: SynthUIButton!
    @IBOutlet weak var holdToggle: SynthUIButton!
    @IBOutlet weak var configureKeyboardButton: SynthUIButton!
    @IBOutlet weak var midiPanicButton: TopUIButton!
    @IBOutlet weak var aboutButton: TopUIButton!
    @IBOutlet weak var octaveStepper: Stepper!
    @IBOutlet weak var bluetoothButton: AKBluetoothMIDIButton!
    @IBOutlet weak var midiSettingsButton: SynthUIButton!
    @IBOutlet weak var midiLearnToggle: SynthUIButton!
    
    var auMainController: AUMainController!
    let conductor = Conductor.sharedInstance
    var randomNumbers: GKRandomDistribution!
    
    var midiChannelIn: MIDIChannel = 0
    var omniMode = true
    
    var currentPresetIndex = 0 {
        didSet {
            if currentPresetIndex > exsPresets.count - 1 {
                currentPresetIndex = 0
            }
            if currentPresetIndex < 0 {
                currentPresetIndex = exsPresets.count - 1
            }
        }
    }
    
    let exsPresets = [
        "TX LoTine81z",
        "TX Metalimba",
        "TX Pluck Bass",
        "TX Brass"
    ]
    
    // **********************************************************
    // MARK: - Life Cycle
    // **********************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Keyboard 🎹
        keyboardView?.delegate = self
        keyboardView?.polyphonicMode = true
        keyboardView?.firstOctave = 2
        octaveStepper.minValue = -2
        octaveStepper.maxValue = 3
        
        // Add MIDI Listener 👂
        conductor.addMidiListener(listener: self)
        
        // Generate random presets 🎲
        randomNumbers = GKShuffledDistribution(lowestValue: 0, highestValue: exsPresets.count - 1)
        currentPresetIndex = 0
        
        // Load Preset 🔊
        updatePreset(position: currentPresetIndex)
        
        // Add Gesture Recognizer to Display Label for Presets Popup
        let tap = UITapGestureRecognizer(target: self, action: #selector(ParentViewController.displayLabelTapped))
        tap.numberOfTapsRequired = 1
        displayLabel.addGestureRecognizer(tap)
        
        // Make bluetooth button look pretty
        bluetoothButton.layer.cornerRadius = 2
        bluetoothButton.layer.borderWidth = 1
        
        // Get Embedded AUController
        if let embeddedController = self.childViewControllers.first as? AUMainController {
            auMainController = embeddedController
        }
        
        // Setup Callbacks
        setupCallbacks()
    }
    
    // **********************************************************
    // MARK: - Actions
    // **********************************************************
    
    @IBAction func rightPresetPressed() {
        currentPresetIndex += 1
        DispatchQueue.main.async {
            self.updatePreset(position: self.currentPresetIndex)
        }
    }
    
    @IBAction func leftPresetPressed() {
        currentPresetIndex -= 1
        DispatchQueue.main.async {
            self.updatePreset(position: self.currentPresetIndex)
        }
    }
    
    @IBAction func keyboardOctChanged(_ sender: UIStepper) {
        keyboardView.firstOctave = Int(sender.value)
    }
    
    @IBAction func randomPressed() {
        // Animate Dice
        UIView.animate(withDuration: 0.4, animations: {
            for _ in 0 ... 1 {
                self.diceButton.transform = self.diceButton.transform.rotated(by: CGFloat(Double.pi))
            }
        })
        
        // Pick random Preset
        var newIndex = randomNumbers.nextInt()
        if newIndex == currentPresetIndex { newIndex = randomNumbers.nextInt() }
        currentPresetIndex = newIndex
        updatePreset(position: currentPresetIndex)
    }
    
    // **********************************************************
    // MARK: - Callbacks
    // **********************************************************
    
    func setupCallbacks() {
        octaveStepper.callback = { value in
            self.keyboardView.firstOctave = Int(value) + 2
        }
        
        midiSettingsButton.callback = { _ in
            self.performSegue(withIdentifier: "SegueToMIDISettingsPopOver", sender: self)
            self.midiSettingsButton.value = 0
        }
        
        monoToggle.callback = { value in
            self.keyboardView.polyphonicMode = !self.monoToggle.isSelected
        }
        
        holdToggle.callback = { value in
            self.keyboardView.holdMode = !self.keyboardView.holdMode
            if value == 0.0 {
                self.conductor.allNotesOff()
            }
        }
        
        configureKeyboardButton.callback = { _ in
            self.configureKeyboardButton.value = 0
            self.performSegue(withIdentifier: "SegueToKeySettingsPopOver", sender: self)
        }
        
        midiPanicButton.callback = { _ in
            self.stopAllNotes()
            self.displayAlertController("Midi Panic", message: "All notes have been turned off.")
        }
        
        midiLearnToggle.callback = { _ in
            // Toggle MIDI Learn Knobs in subview
            self.auMainController.midiKnobs.forEach { $0.midiLearnMode = self.midiLearnToggle.isSelected }
            
            // Update display label
            if self.midiLearnToggle.isSelected {
                self.auMainController.outputLabel.text = "MIDI Learn: Touch a knob to assign"
            } else {
                self.auMainController.outputLabel.text = "MIDI Learn Off"
            }
        }
        
        aboutButton.callback = { _ in
            self.performSegue(withIdentifier: "SegueToAbout", sender: self)
        }
    }
    
    // **********************************************************
    // MARK: - Helper Methods
    // **********************************************************
    
    func stopAllNotes() {
        conductor.allNotesOff()
        keyboardView.allNotesOff()
    }
    
    func updatePreset(position: Int) {
        stopAllNotes()
        let newPreset = exsPresets[position]
        displayLabel.text = newPreset
        conductor.useSound(newPreset)
        
        // reset attack/release knob positions
        auMainController?.attackKnob.knobValue = 0.0
        auMainController?.releaseKnob.knobValue = 0.33
    }
    
    @objc func displayLabelTapped() {
        self.performSegue(withIdentifier: "SegueToPresetController", sender: self)
    }
    
    // **********************************************************
    // MARK: - View Navigation/Embed Helper Methods
    // **********************************************************
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SegueToKeySettingsPopOver" {
            let popOverController = segue.destination as! PopUpKeySettingsController
            popOverController.delegate = self
            popOverController.octaveRange = keyboardView.octaveCount
            popOverController.labelMode = keyboardView.labelMode
            popOverController.darkMode = keyboardView.darkMode
            
            popOverController.preferredContentSize = CGSize(width: 420, height: 400)
            if let presentation = popOverController.popoverPresentationController {
                presentation.backgroundColor = #colorLiteral(red: 0.06666666667, green: 0.06666666667, blue: 0.06666666667, alpha: 1)
                presentation.sourceRect = configureKeyboardButton.bounds
            }
        }
        
        if segue.identifier == "SegueToMIDISettingsPopOver" {
            let popOverController = segue.destination as! PopUpMIDIController
            popOverController.delegate = self
            let userMIDIChannel = omniMode ? -1 : Int(midiChannelIn)
            popOverController.userChannelIn = userMIDIChannel
            
            popOverController.preferredContentSize = CGSize(width: 300, height: 240)
            if let presentation = popOverController.popoverPresentationController {
                presentation.backgroundColor = #colorLiteral(red: 0.06666666667, green: 0.06666666667, blue: 0.06666666667, alpha: 1)
                presentation.sourceRect = midiSettingsButton.bounds
            }
        }
        
        if segue.identifier == "SegueToPresetController" {
            let popOverController = segue.destination as! PopUpPresetController
            popOverController.delegate = self
            popOverController.presets = exsPresets
            popOverController.presetIndex = currentPresetIndex
            popOverController.preferredContentSize = CGSize(width: 228, height: 175)
            if let presentation = popOverController.popoverPresentationController {
                presentation.sourceView = self.view
                presentation.sourceRect = CGRect(x: self.view.bounds.midX, y: 126, width: 0, height: 0)
                presentation.permittedArrowDirections = []
                presentation.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            }
        }
    }
    
}

// **********************************************************
// MARK: - Keyboard Pop Over Delegate
// **********************************************************

extension ParentViewController: KeySettingsPopOverDelegate {
    
    func didFinishSelecting(octaveRange: Int, labelMode: Int, darkMode: Bool) {
        keyboardView.octaveCount = octaveRange
        keyboardView.labelMode = labelMode
        keyboardView.darkMode = darkMode
        keyboardView.setNeedsDisplay()
    }
}

// **********************************************************
// MARK: - MIDI Settings Pop Over Delegate
// **********************************************************

extension ParentViewController: MIDISettingsPopOverDelegate {
    
    func resetMIDILearn() {
        auMainController.midiKnobs.forEach { $0.midiCC = 255 }
    }
    
    func didSelectMIDIChannel(newChannel: Int) {
        if newChannel > -1 {
            midiChannelIn = MIDIByte(newChannel)
            omniMode = false
        } else {
            midiChannelIn = 0
            omniMode = true
        }
    }
}

//*****************************************************************
// MARK: - Pop Up Preset Selector
//*****************************************************************

extension ParentViewController: PresetPopOverDelegate {
    func didSelectNewPreset(presetIndex: Int) {
        currentPresetIndex = presetIndex
        updatePreset(position: currentPresetIndex)
    }
}

// **********************************************************
// MARK: - Keyboard Delegate Note on/off
// **********************************************************

extension ParentViewController: AKKeyboardDelegate {
    
    public func noteOn(note: MIDINoteNumber, velocity: MIDIVelocity = 127) {
        conductor.playNote(note: note, velocity: velocity, channel: midiChannelIn)
    }
    
    public func noteOff(note: MIDINoteNumber) {
        DispatchQueue.main.async {
            self.conductor.stopNote(note: note, channel: self.midiChannelIn)
        }
    }
}

// **********************************************************
// MARK: - AKMIDIListener protocol functions
// **********************************************************

extension ParentViewController: AKMIDIListener  {
    
    func receivedMIDINoteOn(noteNumber: MIDINoteNumber, velocity: MIDIVelocity, channel: MIDIChannel) {
        guard channel == midiChannelIn || omniMode else { return }
        
        DispatchQueue.main.async {
            self.keyboardView.pressAdded(noteNumber, velocity: velocity)
        }
    }
    
    func receivedMIDINoteOff(noteNumber: MIDINoteNumber, velocity: MIDIVelocity, channel: MIDIChannel) {
        guard (channel == midiChannelIn || omniMode) && !keyboardView.holdMode else { return }
        
        DispatchQueue.main.async {
            self.keyboardView.pressRemoved(noteNumber)
        }
    }
    
    // Assign MIDI CC to active MIDI Learn knobs
    func assignMIDIControlToKnobs(cc: MIDIByte) {
        let activeMIDILearnKnobs = auMainController.midiKnobs.filter { $0.isActive }
        activeMIDILearnKnobs.forEach {
            $0.midiCC = cc
            $0.isActive = false
        }
    }
    
    // MIDI Controller input
    func receivedMIDIController(_ controller: MIDIByte, value: MIDIByte, channel: MIDIChannel) {
        guard channel == midiChannelIn || omniMode else { return }
        //print("Channel: \(channel+1) controller: \(controller) value: \(value)")
        
        // If any MIDI Learn knobs are active, assign the CC
        DispatchQueue.main.async {
            if self.midiLearnToggle.isSelected { self.assignMIDIControlToKnobs(cc: controller) }
        }
        
        // Handle MIDI Control Messages
        switch controller {
        case AKMIDIControl.modulationWheel.rawValue:
            self.conductor.tremolo.frequency = Double(value)/12.0
        case AKMIDIControl.damperOnOff.rawValue:
            self.conductor.sampler1.sustainPedal(pedalDown: value > 0)
        default:
          break
        }
        
        // Check for MIDI learn knobs that match controller
        let matchingKnobs = auMainController.midiKnobs.filter { $0.midiCC == controller }
        
        // Set new knob values from MIDI for matching knobs
        matchingKnobs.forEach { midiKnob in
            DispatchQueue.main.async {
                midiKnob.setKnobValueFrom(midiValue: value)
            }
        }
    }
    
    // MIDI Program/Patch Change
    func receivedMIDIProgramChange(_ program: MIDIByte, channel: MIDIChannel) {
        guard channel == midiChannelIn || omniMode else { return }
        
        // Smoothly cycle through presets if MIDI input is greater than preset count
        currentPresetIndex = Int(program) % exsPresets.count
        
        DispatchQueue.main.async {
            self.updatePreset(position: self.currentPresetIndex)
        }
    }
    
    // MIDI Pitch Wheel
    func receivedMIDIPitchWheel(_ pitchWheelValue: MIDIWord, channel: MIDIChannel) {
        guard channel == midiChannelIn || omniMode else { return }
        
        var bendSemi = 0.0
        if pitchWheelValue >= 8192 {
            let scale1 = (Double(pitchWheelValue - 8192) / 8192.0) // * conductor.midiBendRange
            bendSemi = scale1 * 12
        } else {
            let scale1 = Double.scaleEntireRange(Double(pitchWheelValue), fromRangeMin: 0, fromRangeMax: 8192, toRangeMin: 12, toRangeMax: 0)
            bendSemi = -(Double.scaleEntireRange(scale1, fromRangeMin: 0, fromRangeMax: 144, toRangeMin: 0, toRangeMax: 12)) * 12
        }
        conductor.sampler1.pitchBend = bendSemi
    }
    
    // After touch
    func receivedMIDIAfterTouch(_ pressure: MIDIByte, channel: MIDIChannel) {
        guard channel == midiChannelIn || omniMode else { return }
        self.conductor.tremolo.frequency = Double(pressure)/20.0
    }
   
    // MIDI Setup Change
    func receivedMIDISetupChange() {
        print("midi setup change, midi.inputNames: \(conductor.midi.inputNames)")
        let inputNames = conductor.midi.inputNames
        inputNames.forEach { inputName in
            conductor.midi.openInput(inputName)
        }
    }
   
}
