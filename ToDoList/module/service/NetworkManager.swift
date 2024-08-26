//
//  NetworkManager.swift
//  ToDoList
//
//  Created by Ensar on 19.08.2024.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum NetworkError: Error {
    case badURL
    case requestFailed
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(url: URL, decodeType: T.Type) async throws -> T {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decode = try JSONDecoder().decode(T.self, from: data)
            return decode
        } catch {
            throw NetworkError.requestFailed
        }
    }
}


