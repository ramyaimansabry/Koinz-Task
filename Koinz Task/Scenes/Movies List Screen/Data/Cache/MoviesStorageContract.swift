//
//  MoviesStorageContract.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 20/05/2022.
//

import RxSwift

protocol MoviesStorageContract {
    func fetchAll(sortDescriptors: [NSSortDescriptor]) -> [MovieData]
    func save(_ movieData: MovieData)
    func deleteAll()
}
