//
//  ScriptExecutor.swift
//  Carol
//
//  Created by Anagh Sharma on 16/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import Foundation

class ScriptExecutor
{
    var script = NSAppleScript.init()
    var errors: NSDictionary?
    var result = NSAppleEventDescriptor.init()
    
    init(script: String)
    {
        executeScript(script)
    }
    
    func executeScript(_ script: String)
    {
        self.script = NSAppleScript(source: ReadFileContent.shared.getFileContent(fileName: script))!
        result = self.script.executeAndReturnError(&errors)
    }
}
