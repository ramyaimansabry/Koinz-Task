//
//  MoviesListRepository.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import RxSwift

final class MoviesListRepository: MoviesListRepositoryContract {
    private let apiService: APIServiceContract
    
    init(apiService: APIServiceContract = APIService.shared) {
        self.apiService = apiService
    }
    
    func fetchTopRatedMovies(
        with pageIndex: Int
    ) -> Observable<Result<MoviesResponse, BaseError>> {
        let request = APIBuilder()
            .setPath(using: .topRatedMovies, argument: ["\(pageIndex)"])
            .setMethod(using: .get)
            .build()
        
        return apiService
            .request(
                using: request,
                responseType: MoviesResponse.self
            )
    }
}
