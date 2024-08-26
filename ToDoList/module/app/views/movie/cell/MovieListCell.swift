//
//  MovieListCell.swift
//  ToDoList
//
//  Created by Ensar on 19.08.2024.
//

import UIKit

class MovieListCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.backgroundColor = .blue
        label.numberOfLines = 0
    }
    
    func configure(with movie: Movie, viewModel: MovieListViewModelProtocol) {
        label.text = movie.title
        if let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")") {
            Task {
                if let image = await viewModel.fetchImage(for: movie) {
                    self.imageView.image = image
                }
            }
        }
    }
}
