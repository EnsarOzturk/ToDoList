//
//  MovieListCell.swift
//  ToDoList
//
//  Created by Ensar on 19.08.2024.
//

import UIKit

final class MovieListCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.backgroundColor = .blue
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
    }
        
    func updateImage(_ image: UIImage?) {
        imageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
