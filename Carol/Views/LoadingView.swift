//
//  LoadingView.swift
//  Carol
//
//  Created by Anagh Sharma on 13/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var loadingText: String
    var body: some View {
        VStack(spacing: 16) {
            ProgressIndicator(isAnimating: true)
            Text("\(loadingText)")
                .font(.footnote)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(loadingText: "Loading")
    }
}
