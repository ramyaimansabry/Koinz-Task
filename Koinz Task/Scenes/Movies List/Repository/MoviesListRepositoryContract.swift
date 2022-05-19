//
//  MoviesListRepositoryContract.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import RxSwift

protocol MoviesListRepositoryContract {
    func fetchTopRatedMovies(
        with pageIndex: Int
    ) -> Observable<Result<MoviesResponse, BaseError>>
}
