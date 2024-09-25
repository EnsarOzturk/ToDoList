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
    func saveText(_ text: String, at indexPath: IndexPath?)
    func deleteItem(at indexPath: IndexPath)
}

final class NotesViewModel {
    
    weak var delegate: NotesViewModelDelegate?
    var indexPath: IndexPath?
   
    func textValidate(_ text: String?) -> Bool {
        guard let text = text, !text.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
        return true
    }
    
    func cancelButtonTapped() {
        delegate?.popViewController()
    }
    
    func saveButtonTapped(text: String, at indexPath: IndexPath?) {
        if textValidate(text) {
            delegate?.saveText(text, at: indexPath)
            delegate?.popViewController()
        } else {
            delegate?.showAlert()
        }
    }
    
    func deleteButtonTapped() {
        guard let indexPath = indexPath else { return }
        delegate?.deleteItem(at: indexPath)
        delegate?.popViewController()
    }
    

}
