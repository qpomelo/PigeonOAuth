//
//  Encoder.swift
//  PigeonOAuth
//
//  Created by Pomelo on 10/3/2020.
//  Copyright © 2020 QPomelo. All rights reserved.
//

import Foundation

class UrlEncoder {
    
    public static func encode(_ url: URL) -> String {
        self.encode(url.absoluteString)
    }
    
    public static func encode(_ url: String) -> String {
        let encodeUrlString = url.addingPercentEncoding(withAllowedCharacters:
        .urlPathAllowed)!.replacingOccurrences(of: "&", with: "%26").replacingOccurrences(of: "=", with: "%3D").replacingOccurrences(of: "*", with: "%2A").replacingOccurrences(of: "+", with: "%2B").replacingOccurrences(of: "%5F", with: "_").replacingOccurrences(of: "%7E", with: "~").replacingOccurrences(of: "%2E", with: ".").replacingOccurrences(of: "%2C", with: ",").replacingOccurrences(of: "!", with: "%21").replacingOccurrences(of: "'", with: "%27").replacingOccurrences(of: "%2D", with: "-").replacingOccurrences(of: "/", with: "%2F").replacingOccurrences(of: ":", with: "%3A").replacingOccurrences(of: "$", with: "%24").replacingOccurrences(of: "@", with: "%40").replacingOccurrences(of: "(", with: "%28").replacingOccurrences(of: ")", with: "%29")
        return encodeUrlString
    }
    
}
