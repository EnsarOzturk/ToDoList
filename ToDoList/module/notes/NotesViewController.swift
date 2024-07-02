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

class NotesViewController: UIViewController {

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
            textAlert()
        }
    }
    
    private func textAlert() {
        let alertController = UIAlertController(title: "Write something", message: "", preferredStyle: .alert)
           let action = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(action)
           present(alertController, animated: true, completion: nil)
       }
}
