//
//  UserDefaults+Extension.swift
//  ToDoList
//
//  Created by Ensar on 5.07.2024.
//

import Foundation

enum UserDefaultsKey: String {
    case textSave
    
    static func itemState(indexPath: IndexPath) -> String {
        return "itemState_\(indexPath.section)_\(indexPath.row)"
    }
}

class UserDefaultsClass {
    
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
    
    func set(_ value: Bool, forKey key: String) {
        defaults.set(value, forKey: key)
    }
    
    func get(forKey key: String) -> Bool {
        return defaults.bool(forKey: key)
    }
}
