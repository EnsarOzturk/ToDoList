//
//  MovieListViewModel.swift
//  ToDoList
//
//  Created by Ensar on 19.08.2024.
//

import Foundation

protocol MovieListViewModelProtocol: AnyObject {
    var movies: [Movie] { get }
    var numberOfItems: Int { get }
    func fetchMovies()
    func movie(at indexPath: IndexPath) -> Movie
    func sizeForItem(at indexPath: IndexPath, collectionViewWidth: Double) -> CGSize
    func fetchImageData(for movie: Movie) async -> Data?
    func willDisplay(index: Int)
}

protocol MovieListProtocol: AnyObject {
    func reloadData()
    func displayError(_ error: String)
}

final class MovieListViewModel: MovieListViewModelProtocol {
    
    private(set) var movies: [Movie] = []
    weak var view: MovieListViewProtocol?
    private var endpointPage = 1
    
    init(view: MovieListViewProtocol) {
        self.view = view
    }
    
    var numberOfItems: Int {
        movies.count
    }
    
    func fetchMovies() {
        
        Task {
            let result: Result<MovieResponse, NetworkError> = await NetworkManager.shared.request(type: MovieResponse.self, endpoint: HomeEndpointItem(page: String(endpointPage)), decodeType: MovieResponse.self)
            switch result {
            case .success(let response):
                if endpointPage == 1 {
                    movies = response.results
                } else {
                    movies.append(contentsOf: response.results)
                }
                await view?.reloadData()
            case .failure(let error):
                await view?.displayError(error.localizedDescription)
            }
        }
    }
    
    func fetchImageData(for movie: Movie) async -> Data? {
        guard let posterPath = movie.posterPath, let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else {
            return nil
        }
        
        let result: Result<Data, NetworkError> = await NetworkManager.shared.fetchImageData(from: posterUrl)
        
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            await view?.displayError(error.localizedDescription)
            return nil
        }
    }
    
    func movie(at indexPath: IndexPath) -> Movie {
        movies[indexPath.item]
    }
    
    func sizeForItem(at indexPath: IndexPath, collectionViewWidth: Double) -> CGSize {
        let spacing: Double = 20
        let width = (collectionViewWidth - spacing * 3) / 2
        return CGSize(width: width, height: width * 4)
    }
    
    func willDisplay(index: Int) {
        if index < movies.count - 1 {
            endpointPage += 1
            fetchMovies()
        }
    }
}
