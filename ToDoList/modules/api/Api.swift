//
//  API.swift
//  ToDoList
//
//  Created by Ensar on 19.08.2024.
//

import Foundation

struct API {
    static let apiKey = "ff8d5fe53a4adc3caeeb2cdebe5f52b6"
    static let baseURL = "https://api.themoviedb.org/3"
    
    static func moviesUrl() -> URL? {
        return URL(string: "\(baseURL)/movie/popular?api_key=\(apiKey)&language=en-US&page=1")
    }
}
