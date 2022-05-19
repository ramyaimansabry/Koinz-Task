//
//  MovieCell.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingNumberLabel: UILabel!
    @IBOutlet weak var movieImageView: AsyncImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(
        with title: String?,
        and imageURL: String?,
        and voteAverage: Double?
    ) {
        titleLabel.text = title
        ratingNumberLabel.text = "\(voteAverage ?? 0)"
        movieImageView.setImage(using: imageURL)
    }
}
