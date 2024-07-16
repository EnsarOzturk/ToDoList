//
//  UserDefaults+Extension.swift
//  ToDoList
//
//  Created by Ensar on 5.07.2024.
//

import Foundation

struct Key<T> {
    let value: String
}

extension UserDefaults {
    
    func set<T: Codable>(_ value: T, forKey key: Key<T>) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            set(encoded, forKey: key.value)
        }
    }
    
    func get<T: Codable>(forKey key: Key<T>) -> T? {
        if let data = data(forKey: key.value) {
            let decoder = JSONDecoder()
            return try? decoder.decode(T.self, from: data)
        }
        return nil
    }
}

extension Key {
    static var textSave: Key<[String]> {
        return Key<[String]>(value: "textSave")
    }
}
