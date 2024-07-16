//
//  NotesViewModel.swift
//  ToDoList
//
//  Created by Ensar on 11.07.2024.
//

import Foundation

class NotesViewModel {
   
    func textValidate(_ text: String?) -> Bool {
        guard let text = text, !text.isEmpty else {
            return false
        }
        return true
    }
}
