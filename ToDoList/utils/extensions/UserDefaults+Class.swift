//
//  UserDefaults+Extension.swift
//  ToDoList
//
//  Created by Ensar on 5.07.2024.
//

import Foundation

enum UserDefaultsKey: String {
    case textSave
    case itemState
}

final class UserDefaultsClass {
    
    static let shared = UserDefaultsClass()
    private let defaults = UserDefaults.standard
    private init() {}
    
    func set<T: Codable>(_ value: T, forKey key: UserDefaultsKey) {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            defaults.set(encoded, forKey: key.rawValue)
        }
    }
        
    func get<T: Codable>(forKey key: UserDefaultsKey) -> T? {
        if let data = defaults.data(forKey: key.rawValue) {
            let decoder = JSONDecoder()
            return try? decoder.decode(T.self, from: data)
        }
        return nil
    }
    
    func set(_ value: Bool, forKey key: UserDefaultsKey) {
        defaults.set(value, forKey: key.rawValue)
    }
        
    func get(forKey key: UserDefaultsKey) -> Bool {
        return defaults.bool(forKey: key.rawValue)
    }
        
    func remove(forKey key: UserDefaultsKey) {
        defaults.removeObject(forKey: key.rawValue)
    }
}
