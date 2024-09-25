//
//  NotesViewController.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import UIKit

protocol NotesViewControllerDelegate: AnyObject {
    func saveText(_ text: String, at indexPath: IndexPath?)
    func reloadData()
    func deleteItem(at indexPath: IndexPath) // sadece row al
}

final class NotesViewController: UIViewController {
    
    var initialText: String?
    
    struct Constant {
        static let radius: Double = 6
        static let borderWidth: Double = 0.2
        static let title: String = "Notes"
    }
    
    @IBOutlet private var textView: UITextView!
    weak var delegate: NotesViewControllerDelegate?
    private let viewModel = NotesViewModel()
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constant.title
        if let initialText = initialText {
            textView.text = initialText
        }
        
        viewModel.delegate = self
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
        setupCancelButton(action: #selector(NotesViewController.cancelToggleButtonTapped(_:)))
        setupSaveButton(action: #selector(NotesViewController.saveToggleButtonTapped(_:)))
        setupDeleteButton(action: #selector(NotesViewController.deleteToggleButtonTapped(_:)))
    }
    
    @objc func deleteToggleButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.deleteButtonTapped()
    }
    
    @objc func cancelToggleButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.cancelButtonTapped()
    }
    
    @objc func saveToggleButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.saveButtonTapped(text: textView.text, at: indexPath)
    }
}
extension NotesViewController: NotesViewModelDelegate {
    func deleteItem(at indexPath: IndexPath) {
        delegate?.deleteItem(at: indexPath)
        delegate?.reloadData()
        popViewController()
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController().alert(title: "Warning", message: "please write something", actionTitle: "OK") {
            self.textView.becomeFirstResponder()
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveText(_ text: String, at indexPath: IndexPath?) {
        delegate?.saveText(text, at: indexPath)
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
}



