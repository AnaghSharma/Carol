//
//  MainViewController.swift
//  Carol
//
//  Created by Anagh Sharma on 19/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import Foundation
import AppKit
import SwiftUI

class MainViewController: NSViewController, ObservableObject
{
    override func viewDidAppear()
    {
        super.viewDidAppear()
        NotificationCenter.default.post(name: Notification.Name("ViewDidAppear"), object: nil)
    }
}
