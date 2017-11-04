# AudioKit ROM / Sample Player

![AK ROM Player](https://i.imgur.com/B9NJ6Ps.png)

Welcome to the official AudioKit example of a sample-based music instrument written in Swift. It can be modified to play EXS24, Wave, or Sound Fonts. This code is lightweight and demonstrates how you can make a beautiful sounding, pro-level instrument with small amount of code. 

If you're new to [AudioKit](https://audiokitpro.com/audiokit/), you can learn more and view getting started links: [here](https://audiokitpro.com/audiokit/).

To see an example of this code in the app store: Coming Soon.  

## CocoaPods

Run `Pod Install` from command line to add AudioKit & AudioKit UI to project

Then open `RomPlayer.xcworkspace`

## Features

- Beautiful sound engine
- MIDI input for notes, pitch bend, mod wheel, after touch
- On screen "Piano" keyboard that can be customized 
- Reverb, Delay, Bitcrush, AutoPan, Stereo Fatten
- Lowpass Filter and LFO
- MIDI Learn knobs
- Written entirely in Swift 4 & AudioKit 4

## Samples

You can replace the included example sample instruments with your own instruments. Please see the [AKSampler](http://audiokit.io/docs/Classes/AKSampler.html) class on loading different sample types. 

If you normally make Kontakt instruments, you can achieve good results by turning off the effects in your Kontakt instruments, and then converting them to EXS24. Then, remake the effects using AudioKit. That way, you'll have dynamic sounds and complete control over the effects. 

There are all kinds of filters, effects, and other audio manipulation classes included with AudioKit to get you started. You can browse the documentation [here](http://audiokit.io/docs/index.html). 

Or, explore over [100+ playgrounds](http://audiokit.io/playgrounds/) where you can experiment with sound and code.

You may also want to explore AU Lab, a free tool from Apple. It is available from the "more" section of the [Apple Developer portal](https://developer.apple.com/download/more/). As of this text, the current version is in the [Additional Tools for Xcode 9 package](https://download.developer.apple.com/Developer_Tools/Additional_Tools_for_Xcode_9/Additional_Tools_for_Xcode_9.dmg). 

Additionally, these [docs and tips](https://developer.apple.com/library/content/technotes/tn2331/_index.html) will also prove valuable if you want to dive in at a deeper level than the AKSampler. 

### Included Sounds

![AK Sample Player](https://i.imgur.com/8FiDeJH.png)

In this repo, I've included four simple instruments I sampled from my TX81z. The LoTine81z sound includes 3 velocity layers. The others include just enough samples to demonstrate the sounds without bloating the repo size.

You are free to use the four sample instruments included in this repo as you see fit. However, it would be great if you gave credit to this repo, or a friendly shout-out. 

To hear more sounds that I recorded from my DX7, DX7II, and TX81z, please download our free FM Player app in the app store. (Link coming soon)

## Making Graphics

IMPORTANT: You need to change the graphics to upload this app in the app store.  

The easiest way to make graphics with code is to use [PaintCode](https://www.paintcodeapp.com/). I made almost all the graphic elements for this app with PaintCode. I've included the PaintCode source files for most of these UI elements [here](https://github.com/AudioKit/AudioKitGraphics). You can use them as a starting place to learn how to make controls. You can change, the color, sizes, etc.  

![knob in ib](https://i.imgflip.com/1svkul.gif)

If you'd rather make knobs and controls with a graphic rendering software packgage that exports image frames (or a dedicated tool like KnobMan), here's some example code I wrote demonstrating using images to create knobs [here](https://github.com/swiftcodex/3D-Knobs).

![Knobs](http://audiokitpro.com/images/knob.gif) 

## Usage

You are free to:

(1) Use this app as a learning tool.  
(2) Re-skin this app (change the graphics), use your own sound samples, and upload to the app store.   
(3) Change the graphics, use your own sounds, and include this as part a bigger app you are building.

If you use any code, it would be great if you gave this project some credit or a mention. The more love this code receives, the better we can make it for everyone. And, always give AudioKit a shout-out when you can! :) 

If you make an app with this code, please let us know! We think you're awesome, and would love to hear from you and/or feature your app.

IMPORTANT: You must change the graphics and sounds if you upload this to the app store.

## What Sounds Can You Use In Your App?

Please get permission from the content creators before you use any free sounds on the internet. Even if sounds are available for free, it does not mean they are licensed to be used in an interactive app. 

The best thing to do is to create or sample your own custom instruments. Generally, you can sample an acoustic instrument or voice without worry. This includes things like Pianos, Flutes, Horns, Human Voice, Guitars, Hand Claps, Foot stomps, etc.

There is a gray area when it comes to keyboards. You can sample pure synthesizers. However, you can not sample keyboards and synthesizers based on PCM or wavetable samples. E.g. A vintage Juno 106 can be legally sampled. But, a modern Juno can not. The modern version uses recorded oscillator waveforms for its source sounds. A Mini-Moog or DX7 can be sampled. But, from the same era, the Roland D-50 or Korg M1 can not. As they use short PCM samples mixed with the oscillators.  

More examples: A Korg MS-20 can be sampled. However, a microKORG can not. (As the microKORG uses digital audio samples for its oscillators). Modern soft synths like Massive and Serum are also waveform based and can not be sampled. It is also illegal to sample other people's sample libraries and sample based apps (like the app store version of this code). Additionally, modern hardware keyboard workstations are almost completely sample-based and you can not sample anything from those legally. 

Many companies will not hesitate to send you a Cease & Desist notice. For example, Roland has shut down and/or sued many apps, VSTs, and sample libraries (including popular apps like Rebirth). They even shut down a free and open-source web app drum machine reminiscent of a TR-808. 

Bottom line: Even if your app is free and doesn't make any money, don't violate copyright laws. It will save you loads of headaches. And, allows you to focus on making something unique and creative. 

## FAQ

Q: Do I have to pay you anything if I make an app with this code?  

A: Nope. This is open source, you can do whatever you want with it. It's usually cool to thank the project if you use the code. Go build stuff. Enjoy.

Q: How do I add AudioBus like the App Store version of this code?  

A: Our [Analog Synth X](https://github.com/AudioKit/AudioKit/tree/master/Examples/iOS/AnalogSynthX) example uses AudioBus. And here is more information on adding [AudioBus with AudioKit](http://audiokit.io/audiobus/).

## Credits

Code, UI, and Sounds by  
Matthew M. Fecher  
[Matthew@audiokitpro.com](mailto:matthew@audiokitpro.com) | Twitter [@goFecher](http://twitter.com/goFecher) | Github [@swiftcodex](http://github.com/swiftcodex) | 

3D Renderings by  
[Kevin Loustau](https://twitter.com/KevinLoustau)

Additional MIDI Enhancements by  
[Mark Jeschke](https://twitter.com/drumkickapp)

This app would not be possible without all the AudioKit contributors:  
[AudioKit Contributions](https://github.com/AudioKit/AudioKit/graphs/contributors)

## Legal Notices

(i) This is an open-source project intended to bring joy and music to people, and enlighten people on how to build custom instruments and iOS apps. All product names and images, trademarks and artists names are the property of their respective owners, which are in no way associated or affiliated with the creators of this app, including AudioKit, AudioKit Pro, LLC, and the other contributors. Product names and images are used solely for the purpose of identifying the specific products related to synthesizers, sampling, sound design, and music making. Use of these names and images does not imply any cooperation or endorsement. Kontakt is a trademark property of Native Instruments. Roland, TR-808, D-50, Juno, and Juno 106 are trademarks property of Roland Corporation. Korg, microKorg, and MS-20 are trademarks of Korg Inc. Yamaha, DX7, DX7II, and TX81z are trademarks property of Yamaha Corporation. We appreciate their amazing work in creating such classic and inspiring instruments. 

(ii) This Readme text does not constitute legal advice. We take no responsibility for any actions resulting from using this code or sampling based on any of our advice or text. If you are unsure of your usage, please contact a music licensing attorney or the content creators of the sources you are sampling. 
