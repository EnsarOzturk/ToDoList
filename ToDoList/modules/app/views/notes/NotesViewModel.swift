//
//  NotesViewModel.swift
//  ToDoList
//
//  Created by Ensar on 11.07.2024.
//

import Foundation

protocol NotesViewModelDelegate: AnyObject {
    func updateText(_ text: String, at row: Int?)
    func deleteItem(at row: Int?)
}

final class NotesViewModel {
    
    private let view: NotesViewControllerProtocol
    let row: Int?
    weak var delegate: NotesViewModelDelegate?
    
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
            delegate?.updateText(text, at: row)
            view.popViewController()
        } else {
            view.showAlert()
        }
    }
    
    func deleteItem() {
        delegate?.deleteItem(at: row)
    }
}
