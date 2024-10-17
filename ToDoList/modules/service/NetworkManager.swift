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
    
    func request<T: Decodable>(type: T.Type, endpoint: Endpoint) async -> Result<T, NetworkError> {
        guard let url = endpoint.url else {
            return .failure(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return .failure(.requestFailed)
            }
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
                if (error as? DecodingError) != nil {
                    return .failure(.decodingError)
                } else {
                    return .failure(.requestFailed)
            }
        }
    }
    
    func fetchImageData(from url: URL) async -> Result<Data, NetworkError> {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return .failure(.requestFailed)
            }
            return .success(data)
        } catch {
            return .failure(.requestFailed)
        }
    }
}
