//
//  ProgressIndicator.swift
//  Carol
//
//  Created by Anagh Sharma on 13/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import SwiftUI
import AppKit

struct ProgressIndicator: NSViewRepresentable
{
    var isAnimating: Bool
    
    func makeNSView(context: Context) -> NSProgressIndicator
    {
        let progressIndicator = NSProgressIndicator()
        progressIndicator.isIndeterminate = true
        progressIndicator.style = NSProgressIndicator.Style.spinning
        return progressIndicator
    }

    func updateNSView(_ progressIndicator: NSProgressIndicator, context: Context)
    {
      if isAnimating
      {
        progressIndicator.startAnimation(self)
      }
      else
      {
          progressIndicator.stopAnimation(self)
      }
    }
}
