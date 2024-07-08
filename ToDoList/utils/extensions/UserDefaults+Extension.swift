//
//  UserDefaults+Extension.swift
//  ToDoList
//
//  Created by Ensar on 5.07.2024.
//

import Foundation

extension UserDefaults {
    
    private enum Keys {
        static let textSave = "textSave"
    }
    
    func setTextArray(_ array: [String]) {
        set(array, forKey: Keys.textSave)
    }
    
    func getTextArray() -> [String]? {
        return stringArray(forKey: Keys.textSave)
    }
}
