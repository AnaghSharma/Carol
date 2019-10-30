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
                VStack(alignment: .leading, spacing: 16.0)
                {
                    HStack(alignment: .top) {
                        URLImage(URL(string: $viewModel.albumArt.wrappedValue!)!,
                                 processors: [ Resize(size: CGSize(width: 80.0, height: 80.0), scale: NSScreen.main!.backingScaleFactor) ],
                                 content:  {
                                     $0.image
                                         .resizable()
                                         .aspectRatio(contentMode: .fit)
                                        .clipped()
                                    
                        })
                            .cornerRadius(2.0)
                        .frame(height: 72.0)
                        
                        VStack(alignment: .leading, spacing: 20.0)
                        {
                            VStack(alignment: .leading, spacing: 2.0)
                            {
                                Text("\($viewModel.track.wrappedValue!.name)")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("\($viewModel.track.wrappedValue!.artist)")
                                    .font(.caption)
                                    .foregroundColor(Color(NSColor.secondaryLabelColor))
                            }
                            HStack {
                                Text("\($viewModel.track.wrappedValue!.app)")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("AccentColor"))
                                
                            }
                        }
                    }
                    LyricsView(viewModel: viewModel)
                }
                
            }
        }
        .frame(width: 360.0, height: 360.0)
        .padding(.vertical, 8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
