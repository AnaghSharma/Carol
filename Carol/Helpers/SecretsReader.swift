//
//  SecretsReader.swift
//  Carol
//
//  Created by Anagh Sharma on 28/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import Foundation

class SecretsReader
{
    static let shared = SecretsReader()
    
    func getSecretKeys() -> String
    {
        return ReadFileContent.shared.getFileContent(fileName: "Secrets")
    }
}
