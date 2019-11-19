//
//  AboutView.swift
//  Carol
//
//  Created by Anagh Sharma on 18/11/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack (spacing: 36.0) {
            VStack(alignment: .center, spacing: 36.0)
            {
                Image("AboutIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                    .frame(width: 256.0, height: 256.0)
                VStack (spacing: 4.0)
                {
                    Text("Carol")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("V1.0")
                        .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(Color(NSColor.secondaryLabelColor))
                }
            }
            .frame(width: 360.0, alignment: .top)
                VStack(alignment: .leading, spacing: 4.0)
                {
                    Text("PRIVACY POLICY")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(NSColor.secondaryLabelColor))
                    Text("We do not collect any personal data at all.")
                        .font(.footnote)
                        .fontWeight(.regular)
                }
                .padding(16)
                .frame(width: 360.0, alignment: .leading)
            
        }
        .padding(24)
        .frame(width: 360.0, height: 480.0, alignment: .top)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
