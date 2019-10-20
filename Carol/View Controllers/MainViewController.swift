//
//  MainViewController.swift
//  Carol
//
//  Created by Anagh Sharma on 19/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import Foundation
import AppKit
import SwiftUI

class MainViewController: NSViewController
{
    var executedTrackScript = ScriptExecutor.init(script: "GetCurrentTrack")
    
    var artist: String = ""
    var track: String = ""
    var app: String = ""
    
    override func viewDidAppear()
    {
        super.viewDidAppear()
        
        executedTrackScript.executeScript("GetCurrentTrack")
        if (executedTrackScript.result.numberOfItems == 3)
        {
            artist = (executedTrackScript.result.atIndex(1)?.stringValue)!
            track = (executedTrackScript.result.atIndex(2)?.stringValue)!
            app = (executedTrackScript.result.atIndex(3)?.stringValue)!
        }
    }
}
