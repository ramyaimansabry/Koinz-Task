//
//  MoviesListViewController.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import UIKit

class MoviesListViewController: BaseViewController, LoadingDisplayerProtocol {
    private var viewModel = MoviesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindLoadingIndicator(to: viewModel.stateRelay)
        viewModel.fetchMovies()
    }
}
