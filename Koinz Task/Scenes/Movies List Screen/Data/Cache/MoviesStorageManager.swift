//
//  MoviesStorageManager.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 20/05/2022.
//

import RxSwift
import CoreData

class MoviesStorageManager {
    private let mainContext: NSManagedObjectContext
    private let backgroundContext: NSManagedObjectContext
    
    init(
        mainContext: NSManagedObjectContext = CoreDataManager.shared.mainContext,
        backgroundContext: NSManagedObjectContext = CoreDataManager.shared.backgroundContext
    ) {
        self.mainContext = mainContext
        self.backgroundContext = backgroundContext
    }
}

// MARK: - MoviesStorageContract

extension MoviesStorageManager: MoviesStorageContract {
    func fetchAll(
        sortDescriptors: [NSSortDescriptor] = []
    ) -> [MovieData] {
        let fetchRequest = MovieDataEntity.fetchRequest()
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.returnsObjectsAsFaults = false
        
        var logs: [MovieDataEntity] = .init()
        
        mainContext.performAndWait {
            do {
                logs = try mainContext.fetch(fetchRequest)
            } catch {
                print("Error fetching logs, error: \(error.localizedDescription)")
            }
        }
        
        return logs.map({ $0.getMovieData() })
    }
    
    func save(_ movieData: MovieData) {
        backgroundContext.performAndWait {
            let newMovieDataEntity = MovieDataEntity(context: backgroundContext)
            newMovieDataEntity.setData(with: movieData)
            
            save(backgroundContext)
        }
    }
    
    func deleteAll() {
        let deleteRequest = NSBatchDeleteRequest(
            fetchRequest: MovieDataEntity.fetchRequest()
        )
        
        backgroundContext.performAndWait {
            do {
                try backgroundContext.execute(deleteRequest)
                try backgroundContext.save()
            } catch {
                print("Error deleting all logs, error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Private Methods

private extension MoviesStorageManager {
    func save(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            fatalError("Can't save Context with error: \(error)")
        }
    }
}
