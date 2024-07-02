//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import Foundation

class ListViewModel {
    
    var list: [String] = []
    
    func numberOfRows() -> Int {
        return list.count
       }
    
    func cellForRowAt(at indexPath: IndexPath) -> String {
           return list[indexPath.row]
       }
    
    func saveText(_ text: String) {
            list.append(text)
       }
}
