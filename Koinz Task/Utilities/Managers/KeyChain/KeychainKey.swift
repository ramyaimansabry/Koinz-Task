//
//  KeychainKey.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import Foundation

public enum KeychainKey: String, CaseIterable {
    case customerId
    case username
    case password
    
    var value: String {
        return "\(EnvironmentManager.shared.string(key: .productBundle)).\(self.rawValue)"
    }
}
