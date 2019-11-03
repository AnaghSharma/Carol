//
//  TrackViewModel.swift
//  Carol
//
//  Created by Anagh Sharma on 20/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import SwiftUI
import Foundation
import Alamofire
import SwiftyJSON

class TrackViewModel: ObservableObject
{
    @Published var track: Track?
    @Published var hasLyrics: Bool = false
    
    @Published var lyrics: String?
    @Published var albumArt: String?
    private var executedTrackScript = ScriptExecutor()
    
    init()
    {
        track = Track(name: "", artist: "", app: "")
        lyrics = ""
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
            self.track = Track(name: (executedTrackScript.result.atIndex(2)?.stringValue)!, artist: (executedTrackScript.result.atIndex(1)?.stringValue)!, app: (executedTrackScript.result.atIndex(3)?.stringValue)!)
            
            //TODO: Check if Track has actually changed
            getLyrics(artist: self.track!.artist, trackName: self.track!.name)
            albumArt = getAlbumArt(self.track!.app)
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
    
    private func getAlbumArt(_ fromApp: String) -> String
    {
        switch fromApp {
        case "Spotify":
            executedTrackScript.executeScript("GetAlbumArtSpotify")
            return executedTrackScript.result.stringValue!
        case "Music":
            executedTrackScript.executeScript("GetAlbumArtMusic")
            return executedTrackScript.result.stringValue!
        default:
            return ""
        }
    }
    
    private func getLyrics(artist: String, trackName: String)
    {
        let url = "https://api.lyrics.ovh/v1/\(artist)/\(trackName)"
        Alamofire.request(URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.lyrics = json["lyrics"].stringValue
            case .failure(let error):
                //TODO: Show error in UI or Try Musixmatch
                print(error)
            }
        }
    }
    
    func openInApp(openInAppName: String)
    {
        var bundleIdentifier: String = ""
        if openInAppName == "Spotify"
        {
            bundleIdentifier = "com.spotify.client"
        }
        else if openInAppName == "Music"
        {
            bundleIdentifier = "com.Apple.Music"
        }
        
        guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleIdentifier) else { return }
        let configuration = NSWorkspace.OpenConfiguration()
        
        NSWorkspace.shared.openApplication(at: url,
        configuration: configuration,
        completionHandler: nil)
    }
}
