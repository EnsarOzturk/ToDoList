//
//  UserDefaults+Extension.swift
//  ToDoList
//
//  Created by Ensar on 5.07.2024.
//

import Foundation

protocol UserDefaultsAssistantProtocol {
    associatedtype T: Codable & Equatable
    func saveData(_ items: [T], forKey key: String)
    func loadData(forKey key: String) -> [T]
    func removeData(_ item: T, forKey key: String)
}

final class UserDefaultsAssistant<T: Codable & Equatable>: UserDefaultsAssistantProtocol {

    private let userDefaults = UserDefaults.standard

    func saveData(_ items: [T], forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            userDefaults.set(encoded, forKey: key)
        }
    }

    func loadData(forKey key: String) -> [T] {
        if let data = userDefaults.data(forKey: key) {
            let decoder = JSONDecoder()
            if let items = try? decoder.decode([T].self, from: data) {
                return items
            }
        }
        return []
    }

    func removeData(_ item: T, forKey key: String) {
        var items = loadData(forKey: key)
        items.removeAll { $0 == item }
        saveData(items, forKey: key)
    }
}
