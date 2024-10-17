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

final class MovieListViewController: UIViewController {
    
    struct Constant {
        static let identifier: String = "MovieListCell"
    }
    
    @IBOutlet var collectionView: UICollectionView!
    private var viewModel: MovieListViewModelProtocol!
    private var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MovieListViewModel(view: self)
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constant.identifier, bundle: nil), forCellWithReuseIdentifier: Constant.identifier)
        viewModel.fetchMovies()
        setupSearchController()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.filterMovies(with: searchText)
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.identifier, for: indexPath) as! MovieListCell
        let movie = viewModel.movie(at: indexPath.row)
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

extension MovieListViewController: MovieListViewProtocol, AlertDisplaying {
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func displayError(_ error: String) {
        displayAlert(title: "Error", message: "error")
        
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

