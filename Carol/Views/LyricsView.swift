//
//  LyricsView.swift
//  Carol
//
//  Created by Anagh Sharma on 30/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import SwiftUI

struct LyricsView: View {
    @ObservedObject var viewModel = TrackViewModel()
    var body: some View {
        ZStack
            {
                ScrollView()
                    {
                        Text("\(viewModel.lyrics!)")
                            .font(Font.system(size: 21.0))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .animation(.default)
                }
                .padding(.leading, 16)
                .padding(.top, 20)
                .padding(.trailing, 24)
                .padding(.bottom, 24)
        }
        .frame(width: 328.0, height: 256.0)
        .background(Color(NSColor.windowBackgroundColor))
        .cornerRadius(8)
        
    }
}

struct LyricsView_Previews: PreviewProvider {
    static var previews: some View {
        LyricsView()
    }
}
