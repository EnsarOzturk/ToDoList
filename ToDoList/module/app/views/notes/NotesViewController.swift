//
//  NotesViewController.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import UIKit

protocol NotesViewControllerDelegate: AnyObject {
    func saveText(_ text: String, at row: Int?)
    func deleteItem(at row: Int?)
}

protocol NotesViewControllerProtocol: AnyObject {
    func saveText(_ text: String, at row: Int?)
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
    var delegate: NotesViewControllerDelegate?
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
    
    func setupButtons() {
        setupCancelButton(action: #selector(cancelToggleButtonTapped(_:)))
        setupSaveButton(action: #selector(saveToggleButtonTapped(_:)))
        setupDeleteButton(action: #selector(deleteToggleButtonTapped(_:)))
    }
    
    @objc func deleteToggleButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.deleteItem(at: viewModel.row)
        popViewController()
    }
    
    @objc func cancelToggleButtonTapped(_ sender: UIBarButtonItem) {
        popViewController()
    }
    
    @objc func saveToggleButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.saveButtonTapped(text: textView.text)
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    func setupCancelButton(action: Selector) {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: action)
        navigationItem.leftBarButtonItem = cancelButton
        cancelButton.tintColor = .black
    }
    
    func setupSaveButton(action: Selector) {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: action)
        navigationItem.rightBarButtonItem = saveButton
        saveButton.tintColor = .black
    }
    
    func setupDeleteButton(action: Selector) {
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: action)
        deleteButton.tintColor = .black
        navigationItem.rightBarButtonItems = [deleteButton, navigationItem.rightBarButtonItem].compactMap { $0 }
    }
    
    func saveText(_ text: String, at row: Int?) {
        delegate?.saveText(text, at: row)
    }
}

extension NotesViewController: NotesViewControllerProtocol {
    func showAlert() {
        let alert = UIAlertController().alert(title: "Warning", message: "please write something", actionTitle: "OK") {
            self.textView.becomeFirstResponder()
        }
        self.present(alert, animated: true, completion: nil)
    }
}





