//
//  Endpoint.swift
//  ToDoList
//
//  Created by Ensar on 24.09.2024.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String {get}
    var method: HTTPMethod {get }
    var header: [String : String] { get }
    var parameters: [URLQueryItem] {get }
}

extension Endpoint {
    
    var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
        
    var header: [String : String] {
        ["Content-Type": "application/json"]
    }
    
    var url: URL? {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = parameters
        return components?.url
    }
}
