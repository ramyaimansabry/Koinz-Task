//
//  CoreDataStoreType.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 20/05/2022.
//

import Foundation
import CoreData

/// The persistentStore type
/// -  sqLite
/// - inMemory
public enum CoreDataStoreType {
    case sqLite
    case inMemory
}

extension CoreDataStoreType {
    var value: String {
        switch self {
        case .sqLite:
            return NSSQLiteStoreType
            
        case .inMemory:
            return NSInMemoryStoreType
        }
    }
}
