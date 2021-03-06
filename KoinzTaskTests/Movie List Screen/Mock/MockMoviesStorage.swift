//
//  MockMoviesStorage.swift
//  KoinzTaskTests
//
//  Created by Ramy Sabry on 20/05/2022.
//

@testable import Koinz_Task
import RxTest
import RxSwift

final class MockValidMoviesStorage: DisposeObject, MoviesStorageContract {
    func fetchAll(sortDescriptors: [NSSortDescriptor]) -> Observable<Result<[MovieData], BaseError>> {
        return  Observable<Result<[MovieData], BaseError>>.just(
            .success(MockData.moviesData)
        )
    }
    
    func saveAll(_ movies: [MovieData]) {}
    
    func save(_ movieData: MovieData) {}
    
    func deleteAll() {}
}

final class MockInValidMoviesStorage: DisposeObject, MoviesStorageContract {
    func fetchAll(sortDescriptors: [NSSortDescriptor]) -> Observable<Result<[MovieData], BaseError>> {
        return  Observable<Result<[MovieData], BaseError>>.just(
            .failure(MockData.unexpectedError)
        )
    }
    
    func saveAll(_ movies: [MovieData]) {}
    
    func save(_ movieData: MovieData) {}
    
    func deleteAll() {}
}
