//
//  MIDIButton.swift
//  RomPlayer
//
//  Created by Matthew Fecher on 10/18/17.
//  Copyright © 2017 Matthew Fecher. All rights reserved.
//

import AudioKit

@IBDesignable
class MIDIButton: ToggleButton, MIDILearnable {
    
    var midiCC: MIDIByte = 255 // MIDI CC
    var midiPC: MIDIByte = 255 // MIDI ProgramChange
    var midiControlNote: MIDINoteNumber = 255 // Control Button w/ Midi Note
    
    var midiLearnMode = false
    var isActive = false
    var hotspotView = UIView()
    
    // add your implementation code here
}
