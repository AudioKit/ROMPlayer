# AudioKit ROM / Sample Player

![AK ROM Player](https://i.imgur.com/B9NJ6Ps.png)

Welcome to the official AudioKit example of a sample-based music instrument written in Swift. It can be modified to play EXS24, Wave, or Sound Fonts. This code is lightweight and demonstrates how you can make a beautiful sounding, pro-level instrument with small amount of code. 

If you're new to [AudioKit](https://audiokitpro.com/), you can learn more and view getting started links: [here](https://audiokitpro.com/audiokit/).

## App Store Example

Video introduction for this app and project:  
[https://vimeo.com/244897673](https://vimeo.com/244897673)

The AudioKit FM Player is built with this code:  
[Download in App Store here](https://itunes.apple.com/us/app/fm-player-classic-dx-synths/id1307785646?ls=1&mt=8).  

## Code Features

- Beautiful sound engine
- MIDI input for notes, pitch bend, mod wheel, after touch
- On screen "Piano" keyboard that can be customized 
- Reverb, Delay, Bitcrush, AutoPan, Stereo Fatten
- Lowpass Filter and LFO
- MIDI Learn knobs
- Written entirely in Swift 4 & AudioKit 4

## Getting Started

I have tried to streamline this code and focus on the core-functionality to make it easy-to-understand. That being said, audio programming can be challenging. This may be difficult for complete beginners. And, new frameworks can be overwhelming, even for experienced developers. 

**CocoaPods**  
This repo uses CocoaPods to easily add AudioKit to your project. 

Using the `Terminal` app in your mac, change directories to the folder that contains this project. The correct directory contains a file called `podfile`

Run `Pod Install` from the command line. This will add AudioKit & AudioKit UI to project

Then open `RomPlayer.xcworkspace` in Xcode

## Code Requirements

- Mac or computer running Xcode 9 ([Free Download](https://itunes.apple.com/us/app/xcode/id497799835?mt=12))
- Some knowledge of programming, specifically Swift & the iOS SDK

If you are new to iOS development, I highly recommend the [Ray Wenderlich](https://www.raywenderlich.com/) videos. There is also a great tutorial on basic synthesis with AudioKit  [here.](https://www.raywenderlich.com/145770/audiokit-tutorial-getting-started) 


## Included Sounds

![AK Sample Player](https://i.imgur.com/8FiDeJH.png)

In this repo, I've included four simple instruments I sampled from my TX81z. The LoTine81z sound includes 3 velocity layers. The other sounds include a few samples to demonstrate the sounds without bloating the repo size.

You are free to use the instruments included in this repo as you see fit- In a game, music app, or just for whatever. It would be cool if you didn't resell them.


## Using Samples

You can replace the included example sample instruments with your own instruments. 

![add samples](https://i.imgur.com/TX0j9dy.jpg)

1. Add your EXS24 files and samples to the `/Sounds/Sampler Instruments/` directory
2. Type in the name of the instruments in the ParentViewController.swift file

**Other Sampler File Formats**  
This example code loads EXS24 intruments. For loading Sound Fonts or wave files, please see the [AKSampler](http://audiokit.io/docs/Classes/AKSampler.html) documentation for information on loading different sample types. 

You can use a tool you already know (such as Kontakt) to create and arrange the sample instrument key mapping and velocity layers. Then, you can easily convert Kontakt instruments to EXS24 with tools such as [this](http://www.chickensys.com/translator/). Then, remake the effects using AudioKit. That way, you'll have dynamic sounds and complete control over the effects. 

## Sound Manipulation

There are all kinds of filters, effects, and other audio manipulation classes included with AudioKit to get you started. You can browse the documentation [here](http://audiokit.io/docs/index.html). 

And, explore over [100+ playgrounds](http://audiokit.io/playgrounds/), created by the lovely & talented [Aure Prochazka](https://twitter.com/audiokitman). These byte size code playgrounds allow you to easily experiment with sound & code.

You may also want to explore AU Lab, a free tool from Apple. It is available from the "more" section of the [Apple Developer portal](https://developer.apple.com/download/more/). As of this text, the current version is in the [Additional Tools for Xcode 9 package](https://download.developer.apple.com/Developer_Tools/Additional_Tools_for_Xcode_9/Additional_Tools_for_Xcode_9.dmg). 

Additionally, these [docs and tips](https://developer.apple.com/library/content/technotes/tn2331/_index.html) will also prove valuable if you want to dive in at a deeper level than the AKSampler. 

## Making Graphics

IMPORTANT: You need to change the graphics to upload an app to the app store. Apple does not allow apps to use stock template graphics. Plus, you want your app to be part of the expression of your artistic vision. 

For example, if you were releasing a new music album, you would not want to use some one else's album artwork. You would want your own! 

Think of the GUI as an extension of your sample/music artform. It is a way to impress upon users your own style and give them a feel for your sonic personality. 

If graphic coding is not your cup of tea, the easiest way to make synth controls and knobs with code is to use [PaintCode](https://www.paintcodeapp.com/). I made almost all the graphic elements for this app with PaintCode. I've included the PaintCode source files for most of these UI elements [here](https://github.com/AudioKit/AudioKitGraphics). You can use them as a starting place to learn how to make controls. You can start with these files and change the color, sizes, etc. 

Luckily, I've already included the coding part of handling knobs in this repo. You only have to worry about the graphics. 

![knob in ib](https://i.imgflip.com/1svkul.gif)

Or, if you want to just completely use graphics instead of code - 

If you'd rather make knobs and controls with a graphic rendering software packgage that exports image frames (or a dedicated tool like KnobMan), here's some example code I wrote demonstrating using images to create knobs [here](https://github.com/swiftcodex/3D-Knobs).

![Knobs](http://audiokitpro.com/images/knob.gif) 

## Code Usage

You are free to:

(1) Use this app as a learning tool.  
(2) Re-skin this app (change the graphics), use your own sound samples, and upload to the app store.   
(3) Change the graphics, use your own sounds, and include this as part a bigger app you are building.  
(4) Contribute code back to this project and improve this code for other people.

If you use any code, it would be great if you gave this project some credit or a mention. The more love this code receives, the better we can make it for everyone. And, always give AudioKit a shout-out when you can! :) 

If you make an app with this code, please let us know! We think you're awesome, and would love to hear from you and/or feature your app.

IMPORTANT: You must change the graphics and sounds if you upload this to the app store.

## What Sounds Can You Use In Your App?

![DX](https://i.imgur.com/g86gqfI.png)

Please get permission from the content creators before you use any free sounds on the internet. Even if sounds are available for free, it does not mean they are licensed to be used in an interactive app. 

The best thing to do is to create or sample your own custom instruments. Generally, you can sample an acoustic instrument or voice without worry. This includes things like Pianos, Flutes, Horns, Human Voice, Guitars, Hand Claps, Foot stomps, etc.

There is a gray area when it comes to keyboards. You can sample pure synthesizers. However, you can not sample keyboards and synthesizers based on PCM or wavetable samples. E.g. A vintage Juno 106 can be legally sampled. But, a modern Juno can not. The modern version uses recorded oscillator waveforms for its source sounds. A Mini-Moog or DX7 can be sampled. But, from the same era, the Roland D-50 or Korg M1 can not. As they use short PCM samples mixed with the oscillators.  

More examples: A Korg MS-20 can be sampled. However, a microKORG can not. (As the microKORG uses digital audio samples for its oscillators). Modern soft synths like Massive and Serum are also waveform based and can not be sampled. It is also illegal to sample other people's sample libraries and sample based apps (like the app store version of this code). Additionally, modern hardware keyboard workstations are almost completely sample-based and you can not sample anything from those legally. 

Many companies will not hesitate to send you a Cease & Desist notice. For example, hardware manufacturers have shut down and/or sued many apps, VSTs, and sample libraries (including popular apps like Rebirth). They have even shut down a free and open-source web app drum machine reminiscent of a TR-808. 

Bottom line: Even if your app is free and doesn't make any money, don't violate copyright laws. It will save you loads of headaches. And, allows you to focus on making something unique and creative. 

## AudioBus & IAA MIDI

AudioBus requires a unique key for every app. And, adds complexity to the code. As we have other examples of using AudioBus, it was left out of this example to make the ROM Player code focused and easier-to-understand.

However, here's some tips:
There's information on adding [AudioBus with AudioKit](http://audiokit.io/audiobus/) on our doc site. Plus, our [Analog Synth X](https://github.com/AudioKit/AudioKit/tree/master/Examples/iOS/AnalogSynthX) example code is an example of an app using AudioBus.

Need more hints? I got you covered!  

Here's a gist of the AudioBus 3 MIDI listening code in FM Player:
[https://gist.github.com/swiftcodex/fa097afb59ee57ccd29e59dfb2526977](https://gist.github.com/swiftcodex/fa097afb59ee57ccd29e59dfb2526977)

**Host Icon**   
Here's how to add a Host Icon to your app (the icons for AudioBus 3, GarageBand, etc).  

Add these methods to your ParentViewController:
[https://gist.github.com/swiftcodex/3b3dac2699a6e85c5d3fb86fe48e4ccb](https://gist.github.com/swiftcodex/3b3dac2699a6e85c5d3fb86fe48e4ccb)

Then, add a view/imageview to your storyboard where you want the icon to appear. Connect it to the IBAction in the gist.

**Is there a way to listen for IAA MIDI in Swift?**  
Here's a bit of code used in the FM Player to listen for IAA MIDI. I'm pretty sure there's a better way to do this. If anyone has any tips, please let us know. It was added to the ViewDidLoad method in the ParentViewController:
[https://gist.github.com/swiftcodex/27b327d3ca71187ddc47715b19a50977](https://gist.github.com/swiftcodex/27b327d3ca71187ddc47715b19a50977)

Transport Controls - I don't have any experience adding transport controls with Swift. If you get them to work, please get in touch so that we may help other people.


## FAQ

Q: Is this free? I really don't have to pay you anything if I make an app with this code?  

A: Yes! You are correct. This is open source, you can do whatever you want with it. It's usually cool to thank the project if you use the code. Go build stuff. Enjoy.  

Q: How can I ever repay you?

A: If you want to contribute to the AudioKit code, or ROM Player code, there are many things that can be improved. Or, you could pay it forward by helping other developers.  

Q: How do I save FX settings with each patch like in FM Player?

A: Every developer has their own favorite solution for file persistance (saving/loading), we left that out to keep this code focused on music functionality. There are many robust solutions including Core Data and Realm. In FM Player, we used something lightweight and easy, [Disk](https://github.com/saoudrizwan/Disk). It is a wrapper for native Swift 4 functions. And, beginner friendly. Saving and loading data is a very common thing to do in iOS. There are many blogs, books, videos, and even non-music developers that can help you.

Q: My EXS24 files work in the simulator. But, not in a device?

A: The most common cause of this is that the file references in your EXS24 files are pointing to a folder specifically on your computer, and not relative to their current location. Users of your app will not have access to your computer. This is a good error to catch before uploading to the app store! 

Fixing EXS24 file references is beyond the scope of this readme...  

You can fix file refrences with Logic. Or, if you're making Kontakt Libraries and then converting to EXS24 using something like [Chicken Systems Translator](http://www.chickensys.com/translator/), you can fix the file references by making sure you have everything checked properly on [this screen](http://www.chickensys.com/translator/documentation/options/fixreferences.html). And, a good tip is to run the file translating on the EXS24 files again once they are ALREADY in your app bundle folder (/Sounds/Sampler Instruments/). Sometimes I run the translator on EXS24 files twice for good measure.

If this is driving you mad, this [thread](https://github.com/audiokit/AudioKit/issues/903) will help. 

## Thanks and Credits

Huge thanks to all the Beta testers and the folks on the AudioKit Slack Group, AudioBus Forum, & Facebook iPad Muscian's groups! Without out your support and positive feedback and reviews, this would not be possible.

ROM Player Code, UI, and Sounds by  
[Matthew M. Fecher](mailto:matthew@audiokitpro.com) | Twitter [@goFecher](http://twitter.com/goFecher) | Github [@swiftcodex](http://github.com/swiftcodex) | 

AudioKit Founder  
[Aure Prochazka](http://twitter.com/audiokitman)

3D Renderings by  
[Kevin Loustau](https://twitter.com/KevinLoustau)

Additional MIDI Enhancements by  
[Mark Jeschke](https://twitter.com/drumkickapp)

This app would not be possible without all the AudioKit contributors:  
[AudioKit Contributions](https://github.com/AudioKit/AudioKit/graphs/contributors)

## Legal Notices

This is an open-source project intended to bring joy and music to people, and enlighten people on how to build custom instruments and iOS apps. All product names and images, trademarks and artists names are the property of their respective owners, which are in no way associated or affiliated with the creators of this app, including AudioKit, AudioKit Pro, LLC, and the other contributors. Product names and images are used solely for the purpose of identifying the specific products related to synthesizers, sampling, sound design, and music making. Use of these names and images does not imply any cooperation or endorsement. Kontakt is a trademark property of Native Instruments. Roland, TR-808, D-50, Juno, and Juno 106 are trademarks property of Roland Corporation. Korg, microKorg, and MS-20 are trademarks of Korg Inc. Yamaha, DX7, DX7II, and TX81z are trademarks property of Yamaha Corporation. We appreciate their amazing work in creating such classic and inspiring instruments. 

This Readme text does not constitute legal advice. We take no responsibility for any actions resulting from using this code or sampling based on any of our advice or text. If you are unsure of your usage, please contact a music licensing attorney or the content creators of the sources you are sampling.