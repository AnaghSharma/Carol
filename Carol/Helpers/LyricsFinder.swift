//
//  LyricsFinder.swift
//  Carol
//
//  Created by Anagh Sharma on 04/11/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LyricsFinder
{
    private var apiKey: String
    private var trackId: Int?
    private var url: String?
    public var lyrics: String?
    
    init()
    {
        //Read Api Key from somewhere
        apiKey = "API_Key_Here"
    }
    
    
}
