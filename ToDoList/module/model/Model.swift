//
//  Model.swift
//  ToDoList
//
//  Created by Ensar on 23.07.2024.
//

import Foundation

struct ToDoItem: Codable, Equatable  {
    var text: String
    var isChecked: Bool
}
