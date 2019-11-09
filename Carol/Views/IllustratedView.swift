//
//  IllustratedView.swift
//  Carol
//
//  Created by Anagh Sharma on 07/11/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import SwiftUI

struct IllustratedView: View {
    var illustrationImageName: String
    var illustrationText: String
    var body: some View {
        VStack(spacing: -12.0) {
            Image(illustrationImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 256.0, height: 256.0)
            Text("\(illustrationText)")
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundColor(Color(NSColor.secondaryLabelColor))
                .multilineTextAlignment(.center)
                .frame(maxWidth: 224)
        }
    }
}

struct IllustratedView_Previews: PreviewProvider {
    static var previews: some View {
        IllustratedView(illustrationImageName: "IllustrationNoApp", illustrationText: "No music app is running. Play some music from one of the apps.")
            .frame(width: 360.0, height: 360.0)
    }
}
