//
//  AUMainController
//  ROM Player
//
//  Created by Matthew Fecher on 9/20/17.
//  Copyright © 2017 AudioKit Pro. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class AUMainController: UIViewController {
    
    let conductor = Conductor.sharedInstance
    
    @IBOutlet weak var reverbAmtKnob: MIDIKnob!
    @IBOutlet weak var reverbMixKnob: MIDIKnob!
    
    @IBOutlet weak var delayTimeKnob: MIDIKnob!
    @IBOutlet weak var delayFeedbackKnob: MIDIKnob!
    @IBOutlet weak var delayMixKnob: MIDIKnob!
    
    @IBOutlet weak var vol1Knob: MIDIKnob!
    @IBOutlet weak var masterVolume: MIDIKnob!
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var freqKnob: MIDIKnob!
    @IBOutlet weak var rezKnob: MIDIKnob!
    @IBOutlet weak var lfoRateKnob: MIDIKnob!
    @IBOutlet weak var lfoAmtKnob: MIDIKnob!
    
    @IBOutlet weak var autoPanRateKnob: MIDIKnob!
    @IBOutlet weak var distortKnob: MIDIKnob!
    @IBOutlet weak var crushKnob: MIDIKnob!
    
    @IBOutlet weak var sub24Toggle: ToggleButton!
    @IBOutlet weak var fattenToggle: ToggleButton!
    @IBOutlet weak var filterToggle: ToggleButton!
    @IBOutlet weak var reverbToggle: LedButton!
    @IBOutlet weak var delayToggle: LedButton!
    @IBOutlet weak var autoPanToggle: ToggleButton!
    
    @IBOutlet weak var auditionPoly: RadioButton!
    @IBOutlet weak var auditionLead: RadioButton!
    @IBOutlet weak var auditionBass: RadioButton!
    
    @IBOutlet weak var displayContainer: UIView!
    
    var auditionButtons = [RadioButton]()
    var midiKnobs = [MIDIKnob]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set sound defaults and interface control callbacks
        setDefaults()
        setupCallbacks()
       
        // Visualization
        let plot = AKNodeFFTPlot(conductor.reverbMixer, frame: CGRect(x: 0, y: 0, width: 2400, height: 86))
        plot.shouldFill = true
        plot.shouldMirror = true
        plot.shouldCenterYAxis = true
        plot.color = #colorLiteral(red: 0.537254902, green: 0.9019607843, blue: 0.9764705882, alpha: 1)
        plot.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.262745098, alpha: 0)
        plot.gain = 5
        displayContainer.addSubview(plot)
        
        // Create array of MIDIKnobs
        midiKnobs = self.view.subviews.filter { $0 is MIDIKnob } as! [MIDIKnob]
        setupMIDILearnCallbacks()
    }
    
    //*****************************************************************
    // MARK: - Set Defaults
    //*****************************************************************
  
    func setDefaults() {
        
        // Set Default Knob/Control Values
        vol1Knob.range = -9 ... 3
        vol1Knob.value = -2
        conductor.sampler1.amplitude = -2
        
        masterVolume.range = 0 ... 10.0
        masterVolume.value = 6.0
        conductor.masterVolume.volume = 6.0
       
        autoPanRateKnob.range = 0 ... 5
        autoPanRateKnob.taper = 2
        
        reverbAmtKnob.knobValue = 0.7
        conductor.reverb.feedback = 0.7
        reverbMixKnob.value = 0.3
        reverbToggle.value = 1
        
        delayTimeKnob.range = 0 ... 1.0
        delayTimeKnob.value = 0.85
        conductor.multiDelay.time = 0.85
        
        delayFeedbackKnob.range = 0.0 ... 1.0
        delayFeedbackKnob.value = 0.25
        
        delayMixKnob.value = 0.0
        delayToggle.value = 1
       
        freqKnob.range = 100 ... 16000
        freqKnob.taper = 4
        freqKnob.value = 1000
        conductor.filterSection.cutoffFrequency = 1000
        
        rezKnob.range = 0 ... 0.98
        rezKnob.value = 0.4
        conductor.filterSection.resonance = 0.4
        
        lfoAmtKnob.range = 0 ... 1
        lfoAmtKnob.value = 0.5
        conductor.filterSection.lfoAmplitude = 0.5
        
        lfoRateKnob.range = 0 ... 5
        lfoRateKnob.taper = 2.5
        lfoRateKnob.value = 0.5
        conductor.filterSection.lfoRate = 0.5
   
        conductor.tremolo.depth = 0.5
        conductor.tremolo.frequency = 0
        
        distortKnob.range = 0.6 ... 0.99
        distortKnob.value = 0.6
        conductor.decimator.rounding = 0.0
        conductor.decimator.mix = 1.0
        
        crushKnob.range = 0 ... 0.06
        crushKnob.taper = 1.0
        crushKnob.value = 0.0
        conductor.decimator.decimation = 0
        
        // radio buttons
        auditionButtons = [auditionBass, auditionLead, auditionPoly]
        auditionButtons.forEach { $0.alternateButton = auditionButtons }
    }
    
    //*****************************************************************
    // MARK: - Callbacks
    //*****************************************************************
    
    func setupMIDILearnCallbacks() {
        midiKnobs.forEach {
            $0.midiLearnCallback = {
                self.outputLabel.text = "Twist Knob on your MIDI Controller"
            }
        }
    }
    
    func setupCallbacks() {
        
        vol1Knob.callback = { value in
            self.conductor.sampler1.amplitude = value
            self.outputLabel.text = "Vol Boost: \(value.decimalString) db"
        }
        
        masterVolume.callback = { value in
            self.conductor.masterVolume.volume = value
            self.outputLabel.text = "Master Vol: \((value/10).percentageString)"
        }
        
        distortKnob.callback = { value in
            self.conductor.decimator.rounding = value
            self.outputLabel.text = "Distort: \(Double(self.distortKnob.knobValue).percentageString)"
        }
        
        crushKnob.callback = { value in
            self.conductor.decimator.decimation = value
            self.outputLabel.text = "Crusher: \(Double(self.crushKnob.knobValue).percentageString)"
        }
        
        freqKnob.callback = { value in
            self.conductor.filterSection.cutoffFrequency = value
            self.outputLabel.text = "Freq: \(value.decimalString) Hz"
            
            // Adjust LFO Knob
            self.conductor.filterSection.lfoAmplitude = Double(self.lfoAmtKnob.knobValue) * value
        }
        
        rezKnob.callback = { value in
            self.conductor.filterSection.resonance = value
            self.outputLabel.text = "Rez/Q: \(value.decimalString)"
        }
        
        lfoRateKnob.callback = { value in
            self.conductor.filterSection.lfoRate = value
            self.outputLabel.text = "LFO Rate: \(value.decimalString) Hz"
        }
        
        lfoAmtKnob.callback = { value in
            // Calculate percentage of frequency
            let lfoAmp = value * self.conductor.filterSection.cutoffFrequency
            self.conductor.filterSection.lfoAmplitude = lfoAmp
            self.outputLabel.text = "LFO Amt: \(value.percentageString), Freq: \(lfoAmp.decimalString)Hz"
        }
        
        reverbAmtKnob.callback = { value in
            self.conductor.reverb.feedback = value
            if value == 1.0 {
                self.outputLabel.text = "Reverb Level: Blackhole!"
            } else {
                self.outputLabel.text = "Reverb Level: \(value.percentageString)"
            }
          
        }
        
        reverbMixKnob.callback = { value in
            if self.reverbToggle.isOn { self.conductor.reverbMixer.balance = value }
            self.outputLabel.text = "Reverb Wet: \(value.percentageString)"
        }
        
        delayTimeKnob.callback = { value in
            self.conductor.multiDelay.time = value
            self.outputLabel.text = "Time Between Taps: \(value.decimalString)ms"
        }
        
        delayFeedbackKnob.callback = { value in
            self.conductor.multiDelay.feedback = value
            switch value {
            case 0:
                self.outputLabel.text = "Feedback: Basic Multi-taps"
            case 0.99:
                self.outputLabel.text = "Feedback: Blackhole!"
            default:
                self.outputLabel.text = "Feedback knob: \(value.decimalString)"
            }
        }
        
        delayMixKnob.callback = { value in
            guard self.delayToggle.value == 1 else { return }
            self.conductor.multiDelay.balance = value
            self.outputLabel.text = "Delay Dry/Wet: \(value.percentageString)"
        }
        
        autoPanRateKnob.callback = { value in
            self.conductor.autopan.freq = value
            self.outputLabel.text = "Auto Pan Rate: \(value.decimalString) Hz"
        }
        
        auditionBass.callback = { value in
            if value == 1 { self.conductor.midiLoad("rom_bass") }
            self.conductor.sequencerToggle(value)
        }
        
        auditionLead.callback = { value in
            if value == 1 { self.conductor.midiLoad("rom_lead") }
            self.conductor.sequencerToggle(value)
        }
        
        auditionPoly.callback = { value in
            if value == 1 { self.conductor.midiLoad("rom_poly") }
            self.conductor.sequencerToggle(value)
        }
        
        autoPanToggle.callback = { value in
            if value == 0 {
                self.outputLabel.text = "Auto Pan Off"
                self.conductor.autopan.mix = 0
            } else {
                self.outputLabel.text = "Auto Pan On"
                self.conductor.autopan.mix = 1
            }
        }
        
        reverbToggle.callback = { value in
            if value == 0 {
                self.outputLabel.text = "Reverb Off"
                self.conductor.reverbMixer.balance = 0.0
            } else {
                self.outputLabel.text = "Reverb On"
                self.conductor.reverbMixer.balance = self.reverbMixKnob.value
            }
        }
        
        delayToggle.callback = { value in
            if value == 0 {
                self.outputLabel.text = "Delay Off"
                self.conductor.multiDelay.stop()
            } else {
                self.outputLabel.text = "Delay On"
                self.conductor.multiDelay.start()
                self.conductor.multiDelay.balance = self.delayMixKnob.value
            }
        }
        
        filterToggle.callback = { value in
            if value == 0 {
                self.outputLabel.text = "Filter Off"
                self.conductor.filterSection.output.stop()
            } else {
                self.outputLabel.text = "Filter On"
                self.conductor.filterSection.output.start()
            }
        }
        
        fattenToggle.callback = { value in
            if value == 0 {
                self.outputLabel.text = "Stereo Widen Off"
                self.conductor.fatten.dryWetMix.balance = 0
            } else {
                self.outputLabel.text = "Stereo Widen On"
                self.conductor.fatten.dryWetMix.balance = 1
            }
        }
        
    }
    
    //*****************************************************************
    // MARK: - IBActions
    //*****************************************************************
    
    @IBAction func githubPressed(_ sender: Any) {
        if let url = URL(string: "https://github.com/AudioKit/AudioKit") {
            UIApplication.shared.open(url)
        }
    }
    
    
    @IBAction func websitePressed(_ sender: Any) {
        if let url = URL(string: "http://audiokitpro.com") {
            UIApplication.shared.open(url)
        }
    }
    
    
    //*****************************************************************
    // MARK: - Helpers
    //*****************************************************************
    
    func toggleMIDILearn(isOn: Bool) {
        let midiKnobs = self.view.subviews.filter { $0 is MIDIKnob } as! [MIDIKnob]
        midiKnobs.forEach { $0.midiLearnMode = isOn }
    }
    
}

