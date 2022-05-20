//
//  MovieDetailsViewModel.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import Combine

final class MovieDetailsViewModel: BaseViewModel {
    private let posterPath: String?
    
    init(posterPath: String?) {
        self.posterPath = posterPath
        super.init()
    }
}

// MARK: - Output Methods

extension MovieDetailsViewModel {
    func getMovieImageURL() -> String {
        guard let posterPath: String = posterPath else {
            alertItemRelay.accept(.init(message: "Sorry, movie poster is not available"))
            return ""
        }
        
        return NetworkConstants.imageURL + ImageSize.original.rawValue + posterPath
    }
}
