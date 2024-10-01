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
    func setupCancelButton(action: Selector)
    func setupSaveButton(action: Selector)
}

final class NotesViewModel {
    
    weak var delegate: NotesViewModelDelegate?
   
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
    
    func setupButtons() {
        delegate?.setupCancelButton(action: #selector(NotesViewController.cancelToggleButtonTapped(_:)))
        delegate?.setupSaveButton(action: #selector(NotesViewController.saveToggleButtonTapped(_:)))
    }
}
