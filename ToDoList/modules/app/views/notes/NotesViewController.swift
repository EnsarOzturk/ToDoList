//
//  NotesViewController.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import UIKit

protocol NotesViewControllerProtocol: AnyObject {
    func showAlert()
    func popViewController()
}

final class NotesViewController: UIViewController {
    
    var initialText: String?
    
    struct Constant {
        static let radius: Double = 6
        static let borderWidth: Double = 0.2
        static let title: String = "Notes"
    }
    
    @IBOutlet private var textView: UITextView!
    var viewModel: NotesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constant.title
        if let initialText = initialText {
            textView.text = initialText
        }
        
        setupButtons()
        setupTextView()
    }
    
    private func setupTextView() {
        textView.layer.cornerRadius = Constant.radius
        textView.layer.borderWidth = Constant.borderWidth
        textView.tintColor = .black
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.becomeFirstResponder()
    }
    
    private func setupButtons() {
        setupCancelButton(action: #selector(cancelToggleButtonTapped(_:)))
        setupSaveButton(action: #selector(saveToggleButtonTapped(_:)))
        setupDeleteButton(action: #selector(deleteToggleButtonTapped(_:)))
    }
    
    @objc private func deleteToggleButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.deleteItem()
        popViewController()
    }
    
    @objc private func cancelToggleButtonTapped(_ sender: UIBarButtonItem) {
        popViewController()
    }
    
    @objc private func saveToggleButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.saveButtonTapped(text: textView.text)
    }

    private func setupCancelButton(action: Selector) {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: action)
        navigationItem.leftBarButtonItem = cancelButton
        cancelButton.tintColor = .black
    }
    
    private func setupSaveButton(action: Selector) {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: action)
        navigationItem.rightBarButtonItem = saveButton
        saveButton.tintColor = .black
    }
    
    private func setupDeleteButton(action: Selector) {
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: action)
        deleteButton.tintColor = .black
        navigationItem.rightBarButtonItems = [deleteButton, navigationItem.rightBarButtonItem].compactMap { $0 }
    }
}

extension NotesViewController: NotesViewControllerProtocol, AlertDisplaying {
    func showAlert() {
        displayAlert(title: "Warning", message: "please write something")
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
