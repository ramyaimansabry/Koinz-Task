//
//  MoviesListViewController.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import UIKit
import RxCocoa
import RxSwift

class MoviesListViewController: BaseViewController, LoadingDisplayerProtocol {
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MoviesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindLoadingIndicator(to: viewModel.stateRelay)
        setupTableView()
        viewModel.fetchMovies()
    }
}

// MARK: - Private Methods

private extension MoviesListViewController {
    func setupTableView() {
        tableView.registerCellNib(MovieCell.self)
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel
            .movies
            .asObservable()
            .bind(to: tableView.rx.items) { (tableView, _, data) in
                let cell: MovieCell = tableView.dequeue()
                cell.configure(with: data.title, and: data.posterFullURL, and: data.voteAverage)
                return cell
            }
            .disposed(by: disposeBag)
    }
}


// MARK: - UITableViewDelegate

extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width / 2
    }
}
