//
//  MovieDataEntity.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 20/05/2022.
//

import Foundation

extension MovieDataEntity {
    /// Get `MovieData` Data from `MovieDataEntity`
    /// - Returns: MovieData Created from self
    func getMovieData() -> MovieData {
        return MovieData(
            id: Int(self.id),
            adult: nil,
            backdropPath: nil,
            genreIDS: nil,
            originalLanguage: nil,
            originalTitle: nil,
            overview: nil,
            popularity: nil,
            posterPath: self.posterPath,
            releaseDate: nil,
            title: self.title,
            video: nil,
            voteAverage: self.voteAverage,
            voteCount: Int(self.voteCount)
        )
    }
    
    /// Set `MovieData` Data in `MovieDataEntity`
    /// - Parameter data: MovieData data will used to convert
    func setData(with movieData: MovieData) {
        self.id = Int32(movieData.id)
        self.posterPath = movieData.posterPath
        self.title = movieData.title
        self.voteAverage = movieData.voteAverage ?? 0
        self.voteCount = Int32(movieData.voteCount ?? 0)
    }
}
