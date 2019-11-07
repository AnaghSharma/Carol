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
        VStack {
            Image(illustrationImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 256.0, height: 256.0)
            Text("\(illustrationText)")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 224)
        }
    }
}

//struct IllustratedView_Previews: PreviewProvider {
//    static var previews: some View {
//        IllustratedView()
//    }
//}
