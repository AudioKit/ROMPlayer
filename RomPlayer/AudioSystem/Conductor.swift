//
//  Conductor
//  ROM Player
//
//  Created by Matthew Fecher on 7/20/17.
//  Copyright © 2017 AudioKit Pro. All rights reserved.

import AudioKit

class Conductor {
    
    /// Globally accessible
    static let sharedInstance = Conductor()
  
    var sequencer: AKSequencer!
    var sampler1 = AKMIDISampler()
    var decimator: AKDecimator
    var tremolo: AKTremolo
    var fatten: Fatten
    var filterSection: FilterSection
    var autopan: AutoPan
    var multiDelay: PingPongDelay
    var masterVolume = AKMixer()
    var reverb: AKCostelloReverb
    var reverbMixer: AKDryWetMixer
    let midi = AKMIDI()

    init() {
        
        // MIDI Configure
        midi.createVirtualPorts()
        midi.openInput(name: "Session 1")
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
        fatten = Fatten(autopan)
        
        multiDelay = PingPongDelay(fatten)
        
        masterVolume = AKMixer(multiDelay)
     
        reverb = AKCostelloReverb(masterVolume)
        
        reverbMixer = AKDryWetMixer(masterVolume, reverb, balance: 0.3)
       
        // Set Output & Start AudioKit
        AudioKit.output = reverbMixer
        do {
          try AudioKit.start()
        } catch {
          AKLog("Could not start AudioKit.")
        }
  
        // Init sequencer
        midiLoad("rom_poly")
    }

    func playNote(note: MIDINoteNumber, velocity: MIDIVelocity, channel: MIDIChannel) {
        do {
          try sampler1.play(noteNumber: note, velocity: velocity, channel: channel)
        } catch {
          AKLog("Could not play note \(note)")
        }
    }

    func stopNote(note: MIDINoteNumber, channel: MIDIChannel) {
        do {
          try sampler1.stop(noteNumber: note, channel: channel)
        } catch {
          AKLog("Could not stop note \(note)")
        }
    }

    func useSound(_ sound: String) {
        let exsPath = "Sounds/Sampler Instruments/\(sound)"
        
        do {
            try sampler1.loadEXS24(exsPath)
        } catch {
            print("Could not load EXS24")
        }
    }
    
    func midiLoad(_ midiFile: String) {
        let path = "Sounds/midi/\(midiFile)"
        sequencer = AKSequencer(filename: path)
        sequencer.enableLooping()
        sequencer.setGlobalMIDIOutput(sampler1.midiIn)
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
      do {
        for note in 0 ... 127 {
          try sampler1.stop(noteNumber: MIDINoteNumber(note), channel: 0)
        }
      } catch {
        AKLog("Could not stop all notes")
      }
    }
}
