//
//  MovieListViewModel.swift
//  ToDoList
//
//  Created by Ensar on 19.08.2024.
//

import Foundation

protocol MovieListViewModelProtocol: AnyObject {
    var numberOfItems: Int { get }
    func fetchMovies()
    func movie(at row: Int) -> Movie
    func sizeForItem(at indexPath: IndexPath, collectionViewWidth: Double) -> CGSize
    func fetchImageData(for movie: Movie) async -> Data?
    func willDisplay(index: Int)
    func filterMovies(with searchText: String)
}

protocol MovieListProtocol: AnyObject {
    func reloadData()
    func displayError(_ error: String)
}

final class MovieListViewModel: MovieListViewModelProtocol {
    
    private var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
    private var isSearching: Bool = false
    
    weak var view: MovieListViewProtocol?
    private var homePage = 1
    
    init(view: MovieListViewProtocol) {
        self.view = view
    }
    
    var numberOfItems: Int {
        return isSearching ? filteredMovies.count : movies.count
    }
    
    func movie(at row: Int) -> Movie {
        return isSearching ? filteredMovies[row] : movies[row]
    }
    
    func filterMovies(with query: String) {
        isSearching = !query.isEmpty
        if query.isEmpty {
            filteredMovies = []
            view?.reloadData()
        } else {
            Task {
                await searchMovies(query: query)
            }
        }
        Task { view?.reloadData() }
    }
    
    func searchMovies(query: String) async {
        let result: Result<MovieResponse, NetworkError> = await NetworkManager.shared.request(
            type: MovieResponse.self,
            endpoint: HomeEndpointItem.search(query: query))
        
        switch result {
        case .success(let response):
            filteredMovies = response.results
            view?.reloadData()
        case .failure(let error):
            view?.displayError(error.localizedDescription)
        }
    }
    
    func fetchMovies() {
        Task {
            let result: Result<MovieResponse, NetworkError> = await NetworkManager.shared.request(
                type: MovieResponse.self,
                endpoint: HomeEndpointItem.home(page: String(homePage)))
            switch result {
            case .success(let response):
                if homePage == 1 {
                    movies = response.results
                } else {
                    movies.append(contentsOf: response.results)
                }
                view?.reloadData()
            case .failure(let error):
                view?.displayError(error.localizedDescription)
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
            view?.displayError(error.localizedDescription)
            return nil
        }
    }

    func sizeForItem(at indexPath: IndexPath, collectionViewWidth: Double) -> CGSize {
        let spacing: Double = 20
        let width = (collectionViewWidth - spacing * 4) / 2
        return CGSize(width: width, height: width * 4)
    }
    
    func willDisplay(index: Int) {
        if index < movies.count - 1 {
            homePage += 1
            fetchMovies()
        }
    }
    
}
