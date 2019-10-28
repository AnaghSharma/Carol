//
//  TrackViewModel.swift
//  Carol
//
//  Created by Anagh Sharma on 20/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import SwiftUI
import Foundation
import TinyNetworking

class TrackViewModel: ObservableObject
{
    @Published var track: Track?
    @Published var hasLyrics: Bool = false
    
    private var executedTrackScript = ScriptExecutor.init(script: "GetCurrentTrack")
    
    init()
    {
        track = Track(name: "", artist: "", app: "")
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidAppearNotificationReceived(notification:)), name: Notification.Name("ViewDidAppear"), object: nil)
    }
    
    @objc private func viewDidAppearNotificationReceived(notification: Notification)
    {
        setTrack()
    }
    
    private func setTrack()
    {
        hasLyrics = false
        executedTrackScript.executeScript("GetCurrentTrack")
        
        if executedTrackScript.result.numberOfItems == 3
        {
            self.track = Track(name: (executedTrackScript.result.atIndex(1)?.stringValue)!, artist: (executedTrackScript.result.atIndex(2)?.stringValue)!, app: (executedTrackScript.result.atIndex(3)?.stringValue)!)
            hasLyrics = true
        }
        else if executedTrackScript.result.numberOfItems == 0
        {
            switch executedTrackScript.result.stringValue
            {
            case "1":
                print("Nothing playing")
            case "2":
                print("No music app is running")
            case "3":
                print("Multiple tracks playing")
            default:
                print("Could not find the track")
            }
        }
    }
}
