//
//  CredentialsProtocol.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import Foundation

protocol CredentialsProtocol {
    func getValue(for key: KeychainKey) -> String?
    func set(value: String, for key: KeychainKey)
    func delete(service: KeychainKey)
}
