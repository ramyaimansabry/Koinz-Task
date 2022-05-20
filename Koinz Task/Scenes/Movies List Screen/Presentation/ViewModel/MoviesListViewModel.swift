//
//  MoviesListViewModel.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import RxSwift
import RxCocoa

final class MoviesListViewModel: BaseViewModel {
    private let moviesListRepository: MoviesListRepositoryContract
    private var pageIndex: Int = 1
    private var movies: [MovieData] = [] {
        didSet {
            moviesSubject.onNext(movies)
        }
    }
    private(set) var moviesSubject: BehaviorSubject<[MovieData]> = .init(value: [])
    
    init(moviesListRepository: MoviesListRepositoryContract = MoviesListRepository()) {
        self.moviesListRepository = moviesListRepository
    }
}

// MARK: - Input Methods

extension MoviesListViewModel {
    func fetchMovies() {
        guard stateRelay.value != .loading else { return }
        stateRelay.accept(.loading)
        
        moviesListRepository.fetchTopRatedMovies(using: pageIndex)
            .subscribe { [weak self] result in
                guard let self = self else { return }
                
                self.stateRelay.accept(.successful)
                
                if case .failure(let error) = result {
                    self.alertItemRelay.accept(.init(message: error.message))
                    return
                }
                
                guard case .success(let moviesResponse) = result else { return }
                self.handleOnCompleteFetchingData(using: moviesResponse)
            } onError: { [weak self] error in
                guard let self = self else { return }
                self.handleOnErrorFetchingMovies(error)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Output Methods

extension MoviesListViewModel {
    func isWideCell(forCell indexPath: IndexPath) -> Bool {
        guard indexPath.row % 5 == 0 else { return false }
        
        return true
    }
}

// MARK: - Private Methods

private extension MoviesListViewModel {
    func handleOnCompleteFetchingData(using moviesResponse: MoviesResponse) {
        guard let newMovies: [MovieData] = moviesResponse.results, !newMovies.isEmpty else { return }
        self.movies.append(contentsOf: newMovies)
        
        guard let totalPages = moviesResponse.totalPages, totalPages > pageIndex else { return }
        pageIndex += 1
    }
    
    func handleOnErrorFetchingMovies(_ error: Error) {
        guard pageIndex == 1 else { return }
        guard let error = error as? BaseError else { return }
        self.alertItemRelay.accept(.init(message: error.message))
    }
}
