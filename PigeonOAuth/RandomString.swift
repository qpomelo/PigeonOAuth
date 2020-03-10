//
//  RandomString.swift
//  PigeonOAuth
//
//  Created by Pomelo on 10/3/2020.
//  Copyright © 2020 QPomelo. All rights reserved.
//

import Foundation

class RandomString {
    
    public static func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
