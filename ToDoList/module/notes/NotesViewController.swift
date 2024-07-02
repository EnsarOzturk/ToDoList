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

    @IBOutlet var textField: UITextField!
    weak var delegate: NotesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let text = textField.text, !text.isEmpty {
            
            delegate?.saveText(text)
            navigationController?.popViewController(animated: true)
        }
    }
}
