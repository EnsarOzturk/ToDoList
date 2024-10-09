//
//  NotesViewModel.swift
//  ToDoList
//
//  Created by Ensar on 11.07.2024.
//

import Foundation

final class NotesViewModel {
    
    private let view: NotesViewControllerProtocol
    let row: Int?
    
    init(row: Int?, view: NotesViewControllerProtocol) {
        self.row = row
        self.view = view
    }
    
    func textValidate(_ text: String?) -> Bool {
        guard let text = text, !text.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
        return true
    }
    
    func saveButtonTapped(text: String) {
        if textValidate(text) {
            view.saveText(text, at: row)
            view.popViewController()
        } else {
            view.showAlert()
        }
    }
}
