//
//  MovieListViewModel.swift
//  ToDoList
//
//  Created by Ensar on 19.08.2024.
//

import Foundation
import UIKit

protocol MovieListViewModelProtocol: AnyObject {
    var movies: [Movie] { get }
    var numberOfItems: Int { get }
    func fetchMovies()
    func movie(at indexPath: IndexPath) -> Movie
    func sizeForItem(at indexPath: IndexPath, collectionViewWidth: CGFloat) -> CGSize
    func fetchImage(for movie: Movie) async -> UIImage?
}

protocol MovieListProtocol: AnyObject {
    func reloadData()
    func displayError(_ error: String)
}

class MovieListViewModel: MovieListViewModelProtocol {
    
    private(set) var movies: [Movie] = []
    weak var view: MovieListViewProtocol?
    
    init(view: MovieListViewProtocol) {
        self.view = view
    }
    
    var numberOfItems: Int {
        movies.count
    }
    
    func fetchMovies() {
        guard let url = API.moviesUrl() else { return }
        Task {
            let result: Result<MovieResponse, NetworkError> = await NetworkManager.shared.request(url: url, decodeType: MovieResponse.self)
            switch result {
            case .success(let response):
                self.movies = response.results
                self.view?.reloadData()
            case .failure(let error):
                self.view?.displayError(error.localizedDescription)
            }
        }
    }
    
    func fetchImage(for movie: Movie) async -> UIImage? {
        guard let posterPath = movie.posterPath, let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else { return nil }
        let result: Result<Data, NetworkError> = await NetworkManager.shared.request(url: posterUrl, decodeType: Data.self)
        switch result {
            case .success(let data):
                return UIImage(data: data)
            case .failure(let error):
                print(error.localizedDescription)
                return nil
        }
    }
    
    func movie(at indexPath: IndexPath) -> Movie {
        movies[indexPath.item]
    }
    
    func sizeForItem(at indexPath: IndexPath, collectionViewWidth: CGFloat) -> CGSize {
        let spacing: CGFloat = 20
        let width = (collectionViewWidth - spacing * 3) / 2
        return CGSize(width: width, height: width * 4)
    }
}
