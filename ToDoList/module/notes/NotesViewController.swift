//
//  NotesViewController.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import UIKit

protocol NotesViewControllerDelegate: AnyObject {
    func saveText(_ text: String)
}

final class NotesViewController: UIViewController {

    @IBOutlet private var textView: UITextView!
    weak var delegate: NotesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "new note"
        setupTextView()
        setupSaveButton()
        setupCancelButton()
    }
    
    private func setupTextView() {
        textView.layer.cornerRadius = 6
        textView.tintColor = .black
        textView.layer.borderWidth = 0.2
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.becomeFirstResponder()
    }
    
    private func setupCancelButton() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelToggleButtonTapped(_:)))
        navigationItem.leftBarButtonItem = cancelButton
        cancelButton.tintColor = .black
    }
    
    private func setupSaveButton() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveToggleButtonTapped(_:)))
        navigationItem.rightBarButtonItem = saveButton
        saveButton.tintColor = .black
    }
    
    @objc func cancelToggleButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveToggleButtonTapped(_ sender: UIBarButtonItem) {
        if let text = textView.text, !text.isEmpty {
            delegate?.saveText(text)
            navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController().alert(title: "Warning", message: "please write something", actionTitle: "OK") {
                self.textView.becomeFirstResponder()
                }
            self.present(alert, animated: true, completion: nil)
            }
        }
    }


