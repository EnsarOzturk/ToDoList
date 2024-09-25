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
    func sizeForItem(at indexPath: IndexPath, collectionViewWidth: CGFloat) -> CGSize
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
    private var page = 1
    
    init(view: MovieListViewProtocol) {
        self.view = view
    }
    
    var numberOfItems: Int {
        movies.count
    }
    
    func fetchMovies() {
        
        Task {
            let result: Result<MovieResponse, NetworkError> = await NetworkManager.shared.request(type: MovieResponse.self, endpoint: HomeEndpointItem(page: String(page)), decodeType: MovieResponse.self)
            switch result {
            case .success(let response):
                if page == 1 {
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
        guard let posterPath = movie.posterPath, let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else { return nil }
        var imageRequest = URLRequest(url: posterUrl)
        imageRequest.httpMethod = HTTPMethod.GET.rawValue
        
        do {
            let (data, _) = try await URLSession.shared.data(for: imageRequest) // burasıda netwok managerde beslensin
            return data
        } catch {
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
    
    func willDisplay(index: Int) {
        if index < movies.count - 1 {
            page += 1
            fetchMovies()
        }
    }
}
