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
import Network

class TrackViewModel: ObservableObject
{
    @Published var track: Track?
    @Published var hasLyrics: Bool = false
    @Published var albumArt: String?
    
    @Published var state: States
    private var lyricsFinder: LyricsFinder
    private let apiKey: String
    
    enum LyricsService {
        case LyricsOvh
        case MusixMatch
    }
    
    private var executedTrackScript = ScriptExecutor()
    var cursor: NSCursor = NSCursor.currentSystem!
    let monitor = NWPathMonitor()
    let settingsMenu = NSMenu()
    var window: NSWindow!
    let aboutView = AboutView()
    
    init()
    {
        track = Track(name: "", artist: "", app: "", lyrics: "")
        state = States.loading
        lyricsFinder = LyricsFinder()
        apiKey = SecretsReader.shared.getSecretKeys()
        settingsMenu.addItem(withTitle: "About", action: #selector(aboutMenuItemClicked), keyEquivalent: "").target = self
        settingsMenu.addItem(NSMenuItem.separator())
        settingsMenu.addItem(withTitle: "Quit", action: #selector(quitMenuItemClicked), keyEquivalent: "q").target = self
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 360, height: 480),
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.titlebarAppearsTransparent = true
        window.setFrameAutosaveName("About")
        window.contentView = NSHostingView(rootView: aboutView)
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied
            {
                self.state = States.loading
            }
            else if path.status == .unsatisfied
            {
                self.state = States.nointernet
            }
        }
        monitor.start(queue: DispatchQueue.main)
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidAppearNotificationReceived(notification:)), name: Notification.Name("ViewDidAppear"), object: nil)
    }
    
    @objc private func viewDidAppearNotificationReceived(notification: Notification)
    {
        if state == States.nointernet
        {
            
        }
        else
        {
            setTrack()
        }
    }
    
    private func setTrack()
    {
        state = States.loading
        executedTrackScript.executeScript("GetCurrentTrack")
        
        if executedTrackScript.result.numberOfItems == 3
        {
            self.track = Track(name: (executedTrackScript.result.atIndex(2)?.stringValue)!, artist: (executedTrackScript.result.atIndex(1)?.stringValue)!, app: (executedTrackScript.result.atIndex(3)?.stringValue)!, lyrics: "Calling the wordsmith...")
            
            //TODO: Check if Track has actually changed
            getLyrics(artist: self.track!.artist, trackName: self.track!.name, lyricsService: .LyricsOvh)
            albumArt = getAlbumArt(self.track!.app)
        }
        else if executedTrackScript.result.numberOfItems == 0
        {
            switch executedTrackScript.result.stringValue
            {
            case "1":
                state = States.nomusic
            case "2":
                state = States.noapp
            case "3":
                state = States.multiplay
            default:
                state = States.empty
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
            if executedTrackScript.errors?.count == 0
            {
                return executedTrackScript.result.stringValue!
            }
            else
            {
                return "https://www.apple.com/v/apple-music/l/images/shared/og_image__pvk21jd9bj22.png?201911010950"
            }
        default:
            return ""
        }
    }
    
    private func getLyrics(artist: String, trackName: String, lyricsService: LyricsService)
    {
        let url = "https://api.lyrics.ovh/v1/\(artist)/\(trackName)"
        Alamofire.request(URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.state = States.content
                self.track!.lyrics = json["lyrics"].stringValue
            case .failure(_):
                self.getLyrics(artist: artist, trackName: trackName)
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
    
    func changeCursor(currentCursor: NSCursor)
    {
        if currentCursor == NSCursor.arrow
        {
            cursor = NSCursor.pointingHand
            cursor.push()
        }
        else if currentCursor == NSCursor.pointingHand
        {
            cursor.pop()
        }
    }
    
    public func getLyrics(artist: String, trackName: String)
    {
        let url = "https://api.musixmatch.com/ws/1.1/track.search?q_track=\(trackName)&q_artist=\(artist)&apikey=\(apiKey)"
        var trackId = 0
        Alamofire.request(URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                trackId = json["message"]["body"]["track_list"][0]["track"]["track_id"].intValue
            case .failure(let error):
                print(error)
            }
            if(trackId != 0)
            {
                self.getLyricsFromTrackId(artist: artist, trackName: trackName, trackId: trackId)
            }
            else
            {
                self.state = States.empty
            }
        }
    }
    
    private func getLyricsFromTrackId(artist: String, trackName: String, trackId: Int)
    {
        let url = "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=\(trackId)&apikey=\(apiKey)"
        Alamofire.request(URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let uneditedLyrics = json["message"]["body"]["lyrics"]["lyrics_body"].stringValue
                self.state = States.content
                self.track!.lyrics = String(uneditedLyrics.split(separator: String.Element("*"), maxSplits: 1, omittingEmptySubsequences: true)[0])
            case .failure(_):
                self.state = States.empty
            }
        }
    }
    
    func settingsButtonClicked()
    {
        let sender = NSButton()
        NSMenu.popUpContextMenu(settingsMenu, with: NSApplication.shared.currentEvent!, for: sender)
    }
    
    @objc func aboutMenuItemClicked()
    {
        window.makeKeyAndOrderFront(nil)
        window.isReleasedWhenClosed = false
    }
    
    @objc func quitMenuItemClicked()
    {
        NSApplication.shared.terminate(self)
    }
}
