//
//  EndpointItems.swift
//  ToDoList
//
//  Created by Ensar on 30.09.2024.
//

import Foundation

enum HomeEndpointItem: Endpoint {
    case home(page: String)
    
    var path: String {
        switch self {
        case .home:
            return "/movie/popular"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .home(let page):
            return  [
                URLQueryItem(name: "api_key", value: API.apiKey),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: page)
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .home:
            return .GET
        }
    }
}
