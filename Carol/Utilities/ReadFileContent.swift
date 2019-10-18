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
    var filePath: String?
    var contents: String?
    
    private init(){}
    
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

//public class ReadFileContent
//{
//    static let shared = ReadFileContent()
//    var filePath: String
//    let contents: String
//
//    func getContent(fileName: String) -> String
//    {
//        filePath = Bundle.main.path(forResource: fileName, ofType: "txt")!
//        if filePath != nil
//        {
//            do
//            {
//                let contents = try String(contentsOfFile: filePath!)
//            }
//            catch
//            {
//                // contents could not be loaded
//            }
//
//        }
//        else
//        {
//            // file not found!
//        }
//        return contents!
//    }
//}
