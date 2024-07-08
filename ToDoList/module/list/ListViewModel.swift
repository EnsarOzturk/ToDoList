//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import Foundation

protocol ListViewModelProtocol {
    var list: [String] { get set }
    func numberOfRows() -> Int
    func cellForRowAt(at indexPath: IndexPath) -> String
    func getTextArray()
    func saveText(_ text: String)
}

class ListViewModel: ListViewModelProtocol {
    
    var list: [String] = []
    
    func numberOfRows() -> Int {
        list.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> String {
        list[indexPath.row]
    }
    
    func viewDidLoad() {
        
    }
    
    func getTextArray() {
        if let textSave = UserDefaults.standard.getTextArray() {
            list = textSave
        }
    }
    
    func saveText(_ text: String) {
        list.append(text)
        UserDefaults.standard.setTextArray(list)
        
      }
}
