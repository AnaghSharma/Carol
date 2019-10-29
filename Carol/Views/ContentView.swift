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
                    ZStack
                    {
                        ScrollView()
                        {
                            Text("\(viewModel.lyrics!)")
                                .font(Font.system(size: 21.0))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                    }
                    .frame(width: 328.0, height: 256.0)
                    .background(Color(NSColor.windowBackgroundColor))
                    .cornerRadius(8)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
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
