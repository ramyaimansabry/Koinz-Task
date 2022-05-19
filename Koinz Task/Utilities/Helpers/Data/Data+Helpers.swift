//
//  Data+Helpers.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import Foundation

public extension Data {
    var utfString: String? {
        return String(data: self, encoding: .utf8)
    }
    
    func urlSafeBase64EncodedString() -> String {
        return base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}
