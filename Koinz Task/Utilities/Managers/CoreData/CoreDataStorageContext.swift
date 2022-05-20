//
//  CoreDataStorageContext.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 20/05/2022.
//

import CoreData

class CoreDataManager {
    // MARK: - private properities
    
    /// Core Data file name
    private let fileName = "Movies"
    private let careDataFileExtention = "momd"
    
    /// Persistent Container type
    private var storeType: CoreDataStoreType = .sqLite
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = loadFile(
            with: fileName,
            and: careDataFileExtention
        ) else {
            fatalError("\(fileName) not found in bundle")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Can't get NSManagedObjectModel from \(modelURL.absoluteString)")
        }
        
        return managedObjectModel
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(
            name: fileName,
            managedObjectModel: self.managedObjectModel
        )
        
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = storeType.value
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("was unable to load store \(error)")
            }
        }
        
        return persistentContainer
    }()
    
    // MARK: - Properities
    
    static let shared = CoreDataManager()
    
     var mainContext: NSManagedObjectContext {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    var backgroundContext: NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        return context
    }
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Methods
    
    func setup(storeType: CoreDataStoreType) {
        self.storeType = storeType
    }
}

// MARK: - Private Helpers

private extension CoreDataManager {
    /// Get file url with file name & extention on specific bundle
    /// - Returns: URL?
    func loadFile(
        with fileName: String,
        and fileExtension: String,
        and bundle: Bundle = Bundle(for: CoreDataManager.self)
    ) -> URL? {
        return bundle.url(
            forResource: fileName,
            withExtension: fileExtension
        )
    }
}
