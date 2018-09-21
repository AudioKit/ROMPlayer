//
//  PingPongDelay.swift
//  FMPlayer
//
//  Created by Aurelius Prochazka on 11/8/17.
//  Copyright © 2017 AudioKit Pro. All rights reserved.
//

import AudioKit

class PingPongDelay: AKNode, AKInput {
    var rampDuration = 0.2
    
    var mixer: AKDryWetMixer
    var leftDelay = AKVariableDelay()
    var leftDelayDelay = AKVariableDelay()
    var leftCompensator = AKVariableDelay()
    var leftMix = AKMixer()
    
    var rightDelay = AKVariableDelay()
    var delayMixer = AKMixer()
    
    var leftPanner = AKPanner()
    var rightPanner = AKPanner()
    
    var finalBooster = AKBooster()
    
    var time = 0.0 {
        didSet {
            leftCompensator.time = time / 2.0
            leftDelay.time = time
            leftDelayDelay.time = time / 2.0
            rightDelay.time = time
        }
    }
    var feedback = 0.0 {
        didSet {
            leftDelay.feedback = feedback
            rightDelay.feedback = feedback
        }
    }
    
    var balance = 0.0 {
        didSet {
            mixer.balance = balance
        }
    }
    
    
    var inputNode: AVAudioNode {
        return mixer.avAudioNode
    }
    
    func start() {
        finalBooster.gain = 1.0
    }
    
    func stop() {
        finalBooster.gain = 0.0
    }
    
    func clear() {
        //        leftDelay.clear()
        //        leftDelayDelay.clear()
        //        leftCompensator.clear()
        //        rightDelay.clear()
    }
    
    init(_ input: AKNode) {
        
        leftPanner.pan = -1
        rightPanner.pan = 1
        
        leftCompensator.rampDuration = rampDuration
        leftDelayDelay.rampDuration = rampDuration
        leftDelay.rampDuration = rampDuration
        rightDelay.rampDuration = rampDuration
        finalBooster.rampDuration = rampDuration
        
        input >>> leftDelay
        input >>> rightDelay
        input >>> leftCompensator
        
        leftDelay >>> leftDelayDelay
        
        [leftCompensator, leftDelayDelay] >>> leftMix
        
        leftMix >>> leftPanner
        rightDelay >>> rightPanner
        
        [leftPanner, rightPanner] >>> delayMixer >>> finalBooster
        
        mixer = AKDryWetMixer(input, finalBooster, balance: 0.0)
        
        super.init()
        self.avAudioNode = mixer.avAudioNode
    }
}
