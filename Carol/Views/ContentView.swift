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
            if ($viewModel.state.wrappedValue == States.loading)
            {
                LoadingView(loadingText: "Calling the wordsmiths")
                    .animation(.default)
            }
            else
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
        }
        .frame(width: 360.0, height: 360.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
