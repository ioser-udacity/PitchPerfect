//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Richard E Millet on 3/5/15.
//  Copyright (c) 2015 remillet. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {

	var audioPlayer: AVAudioPlayer!
	var recordedAudio: RecordedAudio! // set during seque transition from RecordSoundsViewController
	
	var audioEngine: AVAudioEngine!
	var audioFile:AVAudioFile!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
		audioEngine = AVAudioEngine()
		audioFile = AVAudioFile(forReading: recordedAudio.filePathUrl, error: nil)
	}
	
	override func viewWillAppear(animated: Bool) {
//		var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
//		var urlPath = NSURL(fileURLWithPath: filePath!)
		
		var urlPath = recordedAudio?.filePathUrl
		audioPlayer = AVAudioPlayer(contentsOfURL: urlPath, error: nil)
		audioPlayer.delegate = self
		audioPlayer.enableRate = true
		audioPlayer.prepareToPlay()
		stopButton.hidden = true
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
		stopButton.hidden = true
		println("Hiding the stop button")
	}
	
	private func hideStopButton() {
		self.stopButton.hidden = true
		println("Hiding the stop button")
	}
	
	private func playAudioWithVariablePitch(pitch: Float){
		audioPlayer.stop()
		audioEngine.stop()
		audioEngine.reset()
		stopButton.hidden = false
		
		var audioPlayerNode = AVAudioPlayerNode()
		audioEngine.attachNode(audioPlayerNode)
		
		var changePitchEffect = AVAudioUnitTimePitch()
		changePitchEffect.pitch = pitch
		audioEngine.attachNode(changePitchEffect)
		
		audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
		audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
		
		audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: hideStopButton)
		audioEngine.startAndReturnError(nil)
		
		audioPlayerNode.play()
	}
	
	private func playSound(rate: Float) {
		audioPlayer.rate = rate
		audioPlayer.stop() // a good practice?
		audioPlayer.currentTime = 0
		stopButton.hidden = false
		audioPlayer.play()
		println("Played sound!")
	}
	
	@IBAction func playSoundQuickly(sender: UIButton) {
		//TODO: Play sound quicly
		playSound(1.5)
	}

	@IBAction func playVadarStyle(sender: UIButton) {
		playAudioWithVariablePitch(-1000)
	}
	
	@IBAction func playChipmunkStyle(sender: UIButton) {
		playAudioWithVariablePitch(1000)
	}
	
	@IBAction func playSoundSlowly(sender: UIButton) {
		//TODO: Play sound slowly
		playSound(0.5)
	}
	
	@IBOutlet weak var stopButton: UIButton!
	
	@IBAction func stopPlaying(sender: UIButton) {
		audioPlayer.currentTime = 0
		audioPlayer.stop()
		sender.hidden = true
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
