//
//  Collection+Helpers.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import Foundation

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
