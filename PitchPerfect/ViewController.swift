//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Richard E Millet on 3/4/15.
//  Copyright (c) 2015 remillet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	
	@IBOutlet weak var startRecordingButton: UIButton!
	@IBOutlet weak var stopRecordingButton: UIButton!
	@IBOutlet weak var recordingMessageLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func recordAudio(sender: UIButton) {
		//TODO: Record some audio
		self.recordingMessageLabel.hidden = false
		self.stopRecordingButton.hidden = false
		self.startRecordingButton.enabled = false
		println("Recording in progress...")
	}
	
	@IBAction func stopRecordingAudio(sender: UIButton) {
		self.recordingMessageLabel.hidden = true
		self.stopRecordingButton.hidden = true
		self.startRecordingButton.enabled = true
	}
	
	override func viewWillAppear(animated: Bool) {
		stopRecordingButton.hidden = true
	}
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
		println("prepareForSegue")
	}

}

