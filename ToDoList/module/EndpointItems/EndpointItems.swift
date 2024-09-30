//
//  EndpointItems.swift
//  ToDoList
//
//  Created by Ensar on 30.09.2024.
//

import Foundation

enum EndpointItems: Endpoint {
   
    case homeEndpointItem(page: String)
    
    var path: String {
        switch self {
        case .homeEndpointItem:
            return "/movie/popular"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .homeEndpointItem(let page):
            return  [
                URLQueryItem(name: "api_key", value: API.apiKey),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: page)
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .homeEndpointItem:
            return .GET
        }
    }
}
