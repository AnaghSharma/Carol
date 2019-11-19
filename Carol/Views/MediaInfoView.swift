//
//  MediaInfoView.swift
//  Carol
//
//  Created by Anagh Sharma on 30/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import SwiftUI
import URLImage
import AppKit

struct MediaInfoView: View {
    @ObservedObject var viewModel = TrackViewModel()
    var body: some View {
        HStack(alignment: .top, spacing: 8.0)
        {
            URLImage(URL(string: $viewModel.albumArt.wrappedValue!)!,
                     processors: [ Resize(size: CGSize(width: 80.0, height: 80.0), scale: NSScreen.main!.backingScaleFactor) ],
                     content:  {
                        $0.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                        
            })
                .cornerRadius(4.0)
                .frame(height: 72.0)
                .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.2))
            VStack(alignment: .leading)
            {
                VStack(alignment: .leading, spacing: 2.0)
                {
                    Text("\($viewModel.track.wrappedValue!.name)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .frame(maxWidth: 248, alignment: Alignment.leading)
                    Text("\($viewModel.track.wrappedValue!.artist)")
                        .font(.caption)
                        .foregroundColor(Color(NSColor.secondaryLabelColor))
                }
                Spacer()
                HStack(alignment: .bottom) {
                    HStack {
                        Button(action: {
                            self.viewModel.openInApp(openInAppName: self.$viewModel.track.wrappedValue!.app)
                        }) {
                            HStack(spacing: 4) {
                                Text("\($viewModel.track.wrappedValue!.app)")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("AccentColor"))
                                Image("OpenInIcon")
                                    .resizable()
                                    .frame(width: 12.0, height: 12.0)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .onHover {_ in
                            self.viewModel.changeCursor(currentCursor: NSCursor.current)
                        }
                    }
                    Spacer()
                    Button(action: {
                        self.viewModel.settingsButtonClicked()
                    }) {
                            Image("SettingsIcon")
                                .resizable()
                                .frame(width: 20.0, height: 20.0)
                                .opacity(0.8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .onHover {_ in
                        self.viewModel.changeCursor(currentCursor: NSCursor.current)
                    }
                    .animation(nil)
                }
                .frame(maxWidth: 248)
            }
            .frame(height: 72)
            .animation(.easeInOut)
        }
    }
}

struct MediaInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MediaInfoView()
    }
}
