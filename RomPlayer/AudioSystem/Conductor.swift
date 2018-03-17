//
//  Conductor
//  ROM Player
//
//  Created by Matthew Fecher on 7/20/17.
//  Copyright © 2017 AudioKit Pro. All rights reserved.

import AudioKit

class Conductor {
    
    // Globally accessible
    static let sharedInstance = Conductor()

    var sequencer: AKSequencer!
    var sampler1 = AKSampler()
    var decimator: AKDecimator
    var tremolo: AKTremolo
    var fatten: Fatten
    var filterSection: FilterSection

    var autoPanMixer: AKDryWetMixer
    var autopan: AutoPan

    var multiDelay: PingPongDelay
    var masterVolume = AKMixer()
    var reverb: AKCostelloReverb
    var reverbMixer: AKDryWetMixer
    let midi = AKMIDI()

    init() {
        
        // MIDI Configure
        midi.createVirtualPorts()
        midi.openInput("Session 1")
        midi.openOutput()
    
        // Session settings
        AKAudioFile.cleanTempDirectory()
        AKSettings.bufferLength = .medium
        AKSettings.enableLogging = false
        
        // Allow audio to play while the iOS device is muted.
        AKSettings.playbackWhileMuted = true
     
        do {
            try AKSettings.setSession(category: .playAndRecord, with: [.defaultToSpeaker, .allowBluetooth, .mixWithOthers])
        } catch {
            AKLog("Could not set session category.")
        }
 
        // Signal Chain
        tremolo = AKTremolo(sampler1, waveform: AKTable(.sine))
        decimator = AKDecimator(tremolo)
        filterSection = FilterSection(decimator)
        filterSection.output.stop()

        autopan = AutoPan(filterSection)
        autoPanMixer = AKDryWetMixer(filterSection, autopan)
        autoPanMixer.balance = 0 

        fatten = Fatten(autoPanMixer)
        
        multiDelay = PingPongDelay(fatten)
        
        masterVolume = AKMixer(multiDelay)
     
        reverb = AKCostelloReverb(masterVolume)
        
        reverbMixer = AKDryWetMixer(masterVolume, reverb, balance: 0.3)
       
        // Set Output & Start AudioKit
        AudioKit.output = reverbMixer
        do {
            try AudioKit.start()
        } catch {
            print("AudioKit.start() failed")
        }
        
        // Set a few sampler parameters
        sampler1.ampReleaseTime = 0.5
  
        // Init sequencer
        midiLoad("rom_poly")
    }
    
    func addMidiListener(listener: AKMIDIListener) {
        midi.addListener(listener)
    }

    func playNote(note: MIDINoteNumber, velocity: MIDIVelocity, channel: MIDIChannel) {
        sampler1.play(noteNumber: note, velocity: velocity)
    }

    func stopNote(note: MIDINoteNumber, channel: MIDIChannel) {
        sampler1.stop(noteNumber: note)
    }

    func useSound(_ sound: String) {
        let soundsFolder = Bundle.main.bundleURL.appendingPathComponent("Sounds/sfz").path
        sampler1.unloadAllSamples()
        sampler1.loadUsingSfzFile(folderPath: soundsFolder, sfzFileName: sound + ".sfz")
    }
    
    func midiLoad(_ midiFile: String) {
        let path = "Sounds/midi/\(midiFile)"
        sequencer = AKSequencer(filename: path)
        sequencer.enableLooping()
        sequencer.setGlobalMIDIOutput(midi.virtualInput)
        sequencer.setTempo(100)
    }
    
    func sequencerToggle(_ value: Double) {
        allNotesOff()
        
        if value == 1 {
            sequencer.play()
        } else {
            sequencer.stop()
        }
    }
    
    func allNotesOff() {
        for note in 0 ... 127 {
            sampler1.stop(noteNumber: MIDINoteNumber(note))
        }
    }
}
