//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Richard E Millet on 3/5/15.
//  Copyright (c) 2015 remillet. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

	var audioPlayer: AVAudioPlayer!
	var recordedAudio: RecordedAudio? // set during seque transition from RecordSoundsViewController
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
	}
	
	override func viewWillAppear(animated: Bool) {
//		var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
//		var urlPath = NSURL(fileURLWithPath: filePath!)
		
		var urlPath = recordedAudio?.filePathUrl
		audioPlayer = AVAudioPlayer(contentsOfURL: urlPath, error: nil)
		audioPlayer.enableRate = true
		audioPlayer.prepareToPlay()
		stopButton.hidden = true
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
