//
//  NotesViewModel.swift
//  ToDoList
//
//  Created by Ensar on 11.07.2024.
//

import Foundation

protocol NotesViewModelDelegate: AnyObject {
    func popViewController()
    func showAlert()
    func saveText(_ text: String, at row: Int?)
    func deleteItem(at row: Int)
}

final class NotesViewModel {
    
    weak var delegate: NotesViewModelDelegate?
    private var row: Int?
    
    init(row: Int?) {
        self.row = row
    }
   
    func textValidate(_ text: String?) -> Bool {
        guard let text = text, !text.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
        return true
    }
    
    func cancelButtonTapped() {
        delegate?.popViewController()
    }
    
    func saveButtonTapped(text: String) {
        if textValidate(text) {
            delegate?.saveText(text, at: row)
            delegate?.popViewController()
        } else {
            delegate?.showAlert()
        }
    }
    
    func deleteButtonTapped() {
        guard let row = row else { return }
        delegate?.deleteItem(at: row)
        delegate?.popViewController()
    }
}
