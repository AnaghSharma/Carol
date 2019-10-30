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
            if (!$viewModel.hasLyrics.wrappedValue)
            {
                LoadingView()
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
                    VStack(alignment: .leading)
                    {
                        MediaInfoView(viewModel: viewModel)
                        LyricsView(viewModel: viewModel)
                    }
                    .padding(.vertical, 16)
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
