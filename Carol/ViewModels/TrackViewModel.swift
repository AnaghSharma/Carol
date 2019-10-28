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
        self.track = Track(name: (executedTrackScript.result.atIndex(1)?.stringValue)!, artist: (executedTrackScript.result.atIndex(2)?.stringValue)!, app: (executedTrackScript.result.atIndex(3)?.stringValue)!)
        hasLyrics = true
    }
}
