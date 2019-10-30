//
//  MediaInfoView.swift
//  Carol
//
//  Created by Anagh Sharma on 30/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import SwiftUI
import URLImage

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
                .cornerRadius(2.0)
                .frame(height: 72.0)
            VStack(alignment: .leading, spacing: 20.0)
            {
                VStack(alignment: .leading, spacing: 2.0)
                {
                    Text("\($viewModel.track.wrappedValue!.name)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: 240.0)
                        
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
        .fixedSize()
    }
}

struct MediaInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MediaInfoView()
    }
}
