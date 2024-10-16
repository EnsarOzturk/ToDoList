//
//  Movie.swift
//  ToDoList
//
//  Created by Ensar on 19.08.2024.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String?
    let posterPath: String?
}
