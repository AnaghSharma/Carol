//
//  ContentView.swift
//  Carol
//
//  Created by Anagh Sharma on 13/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//
import SwiftUI
import Foundation

struct ContentView: View {
    @ObservedObject var viewModel = TrackViewModel()
    
    var body: some View {
        Group {
            if (!$viewModel.hasLyrics.wrappedValue)
            {
                LoadingView().frame(width: 360.0, height: 360.0)
            }
            else
            {
                VStack
                {
                    VStack
                    {
                        Text("\($viewModel.track.wrappedValue!.name)")
                        Text("\($viewModel.track.wrappedValue!.artist)")
                        Text("\($viewModel.track.wrappedValue!.app)")
                    }
                    .padding(16)
                    LyricsView(viewModel: viewModel)
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
