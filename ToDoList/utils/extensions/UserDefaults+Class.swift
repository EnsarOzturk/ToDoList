//
//  UserDefaults+Extension.swift
//  ToDoList
//
//  Created by Ensar on 5.07.2024.
//

import Foundation

protocol UserDefaultsAssistantProtocol {
    associatedtype T: Codable & Equatable
    func saveData(_ items: [T])
    func loadData() -> [T]
    func removeData(_ item: T)
}

final class UserDefaultsAssistant<T: Codable & Equatable>: UserDefaultsAssistantProtocol {

    private let userDefaults = UserDefaults.standard
    private let userDefaultsKey: String

    init(key: String) {
        self.userDefaultsKey = key
    }

    func saveData(_ items: [T]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            userDefaults.set(encoded, forKey: userDefaultsKey)
        }
    }

    func loadData() -> [T] {
        if let data = userDefaults.data(forKey: userDefaultsKey) {
            let decoder = JSONDecoder()
            if let items = try? decoder.decode([T].self, from: data) {
                return items
            }
        }
        return []
    }

    func removeData(_ item: T) {
        var items = loadData()
        items.removeAll { $0 == item }
        saveData(items)
    }
}
