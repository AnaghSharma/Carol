//
//  GetFileContents.swift
//  Carol
//
//  Created by Anagh Sharma on 16/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import Foundation

class ReadFileContent
{
    static let shared = ReadFileContent()
    private var filePath: String?
    private var contents: String?
    
    func getFileContent(fileName: String) -> String
    {
        filePath = Bundle.main.path(forResource: fileName, ofType: "txt")
        do
        {
            contents = try String(contentsOfFile: filePath!)
        }
        catch
        {
        
        }
        return contents!
    }
}
