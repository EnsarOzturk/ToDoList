//
//  MovieListViewController.swift
//  ToDoList
//
//  Created by Ensar on 14.08.2024.
//

import UIKit

protocol MovieListViewProtocol: AnyObject {
    func reloadData()
    func displayError(_ error: String)
}

class MovieListViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    private var viewModel: MovieListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MovieListViewModel(view: self)
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellWithReuseIdentifier: "MovieListCell")
        viewModel.fetchMovies()
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        let movie = viewModel.movie(at: indexPath)
        cell.configure(with: movie)
        
        Task {
            if let imageData = await viewModel.fetchImageData(for: movie), let image = UIImage(data: imageData) {
                cell.updateImage(image)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.willDisplay(index: indexPath.row)
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.sizeForItem(at: indexPath, collectionViewWidth: collectionView.frame.width)
    }
}

extension MovieListViewController: MovieListViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func displayError(_ error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}

