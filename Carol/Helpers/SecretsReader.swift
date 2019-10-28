//
//  SecretsReader.swift
//  Carol
//
//  Created by Anagh Sharma on 28/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import Foundation

public class SecretsReader
{
    private static var secrets: Any?
    
    private static func getSecretKeys() -> String
    {
        return ReadFileContent.shared.getFileContent(fileName: "Secrets.json")
    }
    
    public static func getSecrets()
    {
        
    }
}
