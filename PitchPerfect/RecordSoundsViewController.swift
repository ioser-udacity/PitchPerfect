//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Richard E Millet on 3/4/15.
//  Copyright (c) 2015 remillet. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
	
	@IBOutlet weak var startRecordingButton: UIButton!
	@IBOutlet weak var stopRecordingButton: UIButton!
	@IBOutlet weak var recordingMessageLabel: UILabel!
	
	var audioRecorder: AVAudioRecorder!

	func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
		if flag {
			var recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
			performSegueWithIdentifier("stopRecording", sender: recordedAudio)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func recordAudio(sender: UIButton) {
		// Show and hide ui components
		self.recordingMessageLabel.hidden = false
		self.stopRecordingButton.hidden = false
		self.startRecordingButton.enabled = false
		println("Recording in progress...")
		
		// Setup to get current date and time to use as audio file name
		let currentDateTime = NSDate()
		let formatter = NSDateFormatter()
		formatter.dateFormat = "ddMMyyyy-HHmmss"
		let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
		
		// Pick a place to store the audio file we're going to record
		let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
		let pathArray = [dirPath, recordingName]
		let filePath = NSURL.fileURLWithPathComponents(pathArray)
		println(filePath)
		
		// Not sure what these two lines are doing
		var session = AVAudioSession.sharedInstance()
		session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
		
		// Record some audio and save it.
		audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
		audioRecorder.delegate = self // set ouself as an AVAudioRecorderDelegate delegate
		audioRecorder.meteringEnabled = true
		audioRecorder.record()
	}
	
	@IBAction func stopRecordingAudio(sender: UIButton) {
		audioRecorder.stop()
		self.recordingMessageLabel.hidden = true
		self.stopRecordingButton.hidden = true
		self.startRecordingButton.enabled = true
	}
	
	override func viewWillAppear(animated: Bool) {
		stopRecordingButton.hidden = true
		// Not sure what these two lines are doing
		var audioSession = AVAudioSession.sharedInstance()
		audioSession.setActive(false, error: nil)
	}
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
		if let playSoundViewController = segue.destinationViewController as? PlaySoundsViewController {
			playSoundViewController.recordedAudio = sender as? RecordedAudio
		}
		println("prepareForSegue")
	}

}

