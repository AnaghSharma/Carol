//
//  ContentView.swift
//  Carol
//
//  Created by Anagh Sharma on 13/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var executedTrackScript = ScriptExecutor.init(script: "GetCurrentTrack")
    
    var body: some View {
//        LoadingView().frame(width: 360.0, height: 360.0)
        HStack {
            if (executedTrackScript.result.numberOfItems == 3)
            {
                Text("\((executedTrackScript.result.atIndex(1)?.stringValue)!)")
                Text("\((executedTrackScript.result.atIndex(2)?.stringValue)!)")
                Text("\((executedTrackScript.result.atIndex(3)?.stringValue)!)")
                
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
