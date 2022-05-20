//
//  MockValidMoviesListRepository.swift
//  KoinzTaskTests
//
//  Created by Ramy Sabry on 20/05/2022.
//

@testable import Koinz_Task
import RxSwift
import RxTest

final class MockValidMoviesListRepository: DisposeObject, MoviesListRepositoryContract {
    func fetchTopRatedMovies(
        using pageIndex: Int
    ) -> Observable<Result<MoviesResponse, BaseError>> {
        
        return  Observable<Result<MoviesResponse, BaseError>>.just(
            .success(MockData.moviesResponse)
        )
    }
}

final class MockInValidMoviesListRepository: DisposeObject, MoviesListRepositoryContract {
    func fetchTopRatedMovies(
        using pageIndex: Int
    ) -> Observable<Result<MoviesResponse, BaseError>> {

        return  Observable<Result<MoviesResponse, BaseError>>.just(
            .failure(MockData.unexpectedError)
        )
    }
}
