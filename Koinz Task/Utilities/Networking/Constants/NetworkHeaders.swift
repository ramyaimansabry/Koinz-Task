//
//  APIServiceContract.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//
import Foundation

/// Enumeration that represents types of Network Headers
typealias HTTPHeaders = [String: String]

enum HTTPHeader {
    static let contentType = "Content-Type"
    static let clientID = "client_id"
}
