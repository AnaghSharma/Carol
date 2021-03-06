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
        ScrollView()
        {
                Text("\($viewModel.track.wrappedValue!.lyrics)")
                    .font(Font.system(size: 21.0))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: 288.0, alignment: .topLeading)
                    .animation(.easeIn)
        }
        .padding(.leading, 16)
        .padding(.top, 16)
        .padding(.trailing, 24)
        .padding(.bottom, 32)
        .frame(width: 328.0, height: 240.0)
        .fixedSize()
        .background(VisualEffectView(material: NSVisualEffectView.Material.contentBackground, blendingMode: NSVisualEffectView.BlendingMode.withinWindow))
        .cornerRadius(8)
    }
}

struct LyricsView_Previews: PreviewProvider {
    static var previews: some View {
        LyricsView()
    }
}
