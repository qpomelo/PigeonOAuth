//
//  Credential.swift
//  PigeonOAuth
//
//  Created by Pomelo on 10/3/2020.
//  Copyright © 2020 QPomelo. All rights reserved.
//

import Foundation

public struct Credential {
    
    public init(version: OAuthVersion, consumerKey: String, consumerSecret: String, accessToken: String, accessSecret: String) {
        self.version = version
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.accessToken = accessToken
        self.accessSecret = accessSecret
    }
    
    public var version: OAuthVersion
    
    public var consumerKey: String
    
    public var consumerSecret: String
    
    public var accessToken: String = ""
    
    public var accessSecret: String = ""
    
}

public enum OAuthVersion {
    case v1
    case v2
}
