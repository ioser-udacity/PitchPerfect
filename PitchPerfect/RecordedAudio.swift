//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Richard E Millet on 3/8/15.
//  Copyright (c) 2015 remillet. All rights reserved.
//

import Foundation

class RecordedAudio {
	var filePathUrl: NSURL!
	var title: String!
	
	init(filePathUrl: NSURL, title: String) {
		self.filePathUrl = filePathUrl
		self.title = title
	}
}