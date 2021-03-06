//
//  ContentView.swift
//  Carol
//
//  Created by Anagh Sharma on 13/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//
import SwiftUI
import Foundation
import URLImage

struct ContentView: View {
    @ObservedObject var viewModel = TrackViewModel()
    
    var body: some View {
        Group {
            if ($viewModel.state.wrappedValue == States.nointernet)
            {
                IllustratedView(illustrationImageName: "IllustrationNoInternet", illustrationText: "Looks like there is no internet connection.")
            }
            else
            {
                if ($viewModel.state.wrappedValue == States.loading)
                {
                    LoadingView(loadingText: "Calling the wordsmiths")
                        .animation(.default)
                }
                else
                {
                    if($viewModel.state.wrappedValue == States.content)
                    {
                        ZStack
                        {
                            URLImage(URL(string: $viewModel.albumArt.wrappedValue!)!,
                                     processors: [ Resize(size: CGSize(width: 360.0, height: 360.0), scale: NSScreen.main!.backingScaleFactor) ],
                                     content:  {
                                        $0.image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipped()
                                        
                            })
                            VisualEffectView(material: NSVisualEffectView.Material.underWindowBackground, blendingMode: NSVisualEffectView.BlendingMode.withinWindow)
                            VStack(alignment: .leading, spacing: 16)
                            {
                                MediaInfoView(viewModel: viewModel)
                                    .padding(.top, 4)
                                LyricsView(viewModel: viewModel)
                            }
                        }
                    }
                    else if($viewModel.state.wrappedValue == States.empty)
                    {
                        IllustratedView(illustrationImageName: "IllustrationEmpty", illustrationText: "Oops, could not find the lyrics of this track. Please try again.")
                    }
                    else if($viewModel.state.wrappedValue == States.noapp)
                    {
                        IllustratedView(illustrationImageName: "IllustrationNoApp", illustrationText: "No music app is running. Play some music from one of the apps.")
                    }
                    else if($viewModel.state.wrappedValue == States.nomusic)
                    {
                        IllustratedView(illustrationImageName: "IllustrationNoMusic", illustrationText: "No track is playing. Play something from your awesome collection.")
                    }
                    else if($viewModel.state.wrappedValue == States.multiplay)
                    {
                        IllustratedView(illustrationImageName: "IllustrationMultiplay", illustrationText: "Playing two songs at a time, living in 2050.")
                    }
                }
            }
        }
        .frame(width: 360.0, height: 360.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
