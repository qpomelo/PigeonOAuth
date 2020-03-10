//
//  Maker.swift
//  PigeonOAuth
//
//  Created by Pomelo on 10/3/2020.
//  Copyright © 2020 QPomelo. All rights reserved.
//

import Foundation

public class Maker {
    
    var credential: Credential
    
    public init(credential: Credential) {
        self.credential = credential
    }
    
    public func makeAuthorizationHeader(
        _ method: HTTPMethods,
        _ uri: URLComponents,
        _ headers: [String: String],
        _ timeInterval: Int64 = Int64(NSDate().timeIntervalSince1970),
        _ nonce: String = "{{placeholder}}"
    ) -> [String: String] {
        
        var components = uri
        let queryString = components.query
        components.query = nil
        
        var usingNonce = nonce
        if nonce == "{{placeholder}}" {
            usingNonce = RandomString.randomString(length: 10)
        }
        
        var headerWithAuth = headers
        headerWithAuth["oauth_consumer_key"] = credential.consumerKey
        headerWithAuth["oauth_token"] = credential.accessToken
        headerWithAuth["oauth_signature_method"] = "HMAC-SHA1"
        headerWithAuth["oauth_timestamp"] = String(timeInterval)
        headerWithAuth["oauth_nonce"] = usingNonce
        headerWithAuth["oauth_version"] = "1.0"
        
        for query in (queryString?.split(separator: "&"))! {
            let keyAndValue = query.split(separator: "=")
            if keyAndValue.count == 2 {
                headerWithAuth[String(keyAndValue[0])] = String(keyAndValue[1])
            }
        }
        
        let signature = makeSignature(method, components, headerWithAuth)

        headerWithAuth = headers
        headerWithAuth["Authorization"] = "OAuth oauth_consumer_key=\"\(credential.consumerKey)\",oauth_token=\"\(credential.accessToken)\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"\(timeInterval)\",oauth_nonce=\"\(usingNonce)\",oauth_version=\"1.0\",oauth_signature=\"\(signature)\""
        
        return headerWithAuth
    }
    
    
    /// Make a oauth signature
    /// - parameter method: HTTP method (e.g .get)
    /// - parameter uri: Quest uri (e.g https://api.twitter.com/1.1/statuses/show.json?id=1)
    /// - parameter headers: HTTP headers
    /// - returns: A oauth signature string
    public func makeSignature(_ method: HTTPMethods, _ uri: URLComponents, _ headers: [String: String]) -> String {
        
        // make base string
        let methodString: String = method.rawValue
        let encodedUri: String = UrlEncoder.encode(uri.string ?? "")
        
        var headersWithoutSignature = headers
        headersWithoutSignature.removeValue(forKey: "oauth_signature")
        let sortedHeaders = headersWithoutSignature.sorted { (str1, str2) -> Bool in
            return str1.0 < str2.0
        }
        var headersString = ""
        var index = 0
        for header in sortedHeaders {
            headersString += "\(header.key)=\(header.value)\(index == sortedHeaders.count - 1 ? "" : "&")"
            index += 1
        }
        headersString = UrlEncoder.encode(headersString)
        
        let baseString = "\(methodString)&\(encodedUri)&\(headersString)"
        
        // make secret
        let secretString = "\(credential.consumerSecret)&\(credential.accessSecret)"
        
        let signature = baseString.hmac(algorithm: HMACAlgorithm.SHA1, key: secretString.data(using: .utf8)! as NSData)
        return signature
    }
}
