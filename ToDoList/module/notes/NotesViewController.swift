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

    @IBOutlet var textView: UITextView!
    weak var delegate: NotesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "new note"
        textView.layer.cornerRadius = 6
        textView.tintColor = .black
        textView.layer.borderWidth = 0.2
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let text = textView.text, !text.isEmpty {
            delegate?.saveText(text)
            navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController.alert(title: "Warning", message: "Write something", actionTitle: "OK") {
                }
            present(alert, animated: true)
            textView.becomeFirstResponder()
            }
        }
    }

