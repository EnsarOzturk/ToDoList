//
//  EndpointItems.swift
//  ToDoList
//
//  Created by Ensar on 30.09.2024.
//

import Foundation

enum HomeEndpointItem: Endpoint {
    case home(page: String)
    case search(query: String)
    
    var path: String {
        switch self {
        case .home:
            return "/movie/popular"
        case .search:
            return "/search/movie"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .home(let page):
            return [
                URLQueryItem(name: "api_key", value: API.apiKey),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: page)
            ]
        case .search(query: let query):
            return [
                URLQueryItem(name: "api_key", value: API.apiKey),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "query", value: query)
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .home:
            return .GET
        case .search:
            return .GET
        }
    }
}
