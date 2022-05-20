//
//  MoviesListRepository.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import RxSwift

final class MoviesListRepository: MoviesListRepositoryContract {
    private let apiService: APIServiceContract
    private let storage: MoviesStorageContract
    private let reachability: ReachabilityContract
    private let disposeBag: DisposeBag
    
    init(
        apiService: APIServiceContract = APIService.shared,
        storage: MoviesStorageContract = MoviesStorageManager(),
        reachability: ReachabilityContract = ReachabilityManager(),
        disposeBag: DisposeBag = DisposeBag()
    ) {
        self.apiService = apiService
        self.storage = storage
        self.reachability = reachability
        self.disposeBag = disposeBag
    }
    
    func fetchTopRatedMovies(
        using pageIndex: Int
    ) -> Observable<Result<MoviesResponse, BaseError>> {
        guard reachability.isConnectedToNetwork() else {
            return fetchFromCache()
        }
        
        return fetchFromRemoteAndSaveInCache(using: pageIndex)
    }
}

// MARK: - Private Methods

private extension MoviesListRepository {
    func fetchFromRemoteAndSaveInCache(
        using pageIndex: Int
    ) -> Observable<Result<MoviesResponse, BaseError>> {
        let remoteObserver = fetchFromRemote(using: pageIndex)
        
        remoteObserver.subscribe(onNext: { result in
            if case .success(let response) = result, let movies = response.results {
                self.storage.saveAll(movies)
            }
        })
            .disposed(by: disposeBag)
        
        return remoteObserver
    }
    
    func fetchFromCache() -> Observable<Result<MoviesResponse, BaseError>> {
        let cacheObserver = storage.fetchAll(sortDescriptors: [])
        
        return cacheObserver.map { result in
            guard let movies: [MovieData] = try? result.get() else {
                return .failure(ErrorResolver.shared.getError(for: .exception))
            }
            
            return .success(
                MoviesResponse(
                    results: movies,
                    totalPages: 0
                )
            )
        }
    }
    
    func fetchFromRemote(
        using pageIndex: Int
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
