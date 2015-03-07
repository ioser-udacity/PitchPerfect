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
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
		var urlPath = NSURL(fileURLWithPath: filePath!)
		audioPlayer = AVAudioPlayer(contentsOfURL: urlPath, error: nil)
		audioPlayer.enableRate = true
		audioPlayer.prepareToPlay()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	@IBAction func playSoundSlowly(sender: UIButton) {
		//TODO: Play sound slowly

		audioPlayer.rate = 0.5
		audioPlayer.stop() // a good practice?
		audioPlayer.currentTime = 0
		audioPlayer.play()
		println("Played sound!")
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
