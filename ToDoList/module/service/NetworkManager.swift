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
    
    func request<T: Decodable>(url: URL, method: HTTPMethod = .GET, body: Data? = nil, decodeType: T.Type) async -> Result<T, NetworkError> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch {
            if (error as? URLError) != nil {
                return .failure(.requestFailed)
            } else if (error as? DecodingError) != nil {
                return .failure(.decodingError)
            } else {
                return .failure(.badURL)
            }
        }
    }
}


