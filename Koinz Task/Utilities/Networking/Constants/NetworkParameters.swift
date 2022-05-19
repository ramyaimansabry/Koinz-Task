//
//  APIServiceContract.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//
import Foundation

/// Enumeration that represents type of Network Parameters
typealias Parameters = [String: Any]

enum RequestParams {
    case body(_: Parameters)
    case query(_: Parameters)
}
