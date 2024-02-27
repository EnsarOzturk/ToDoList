//
//  AddListViewController.swift
//  ToDoList
//
//  Created by Ensar on 27.02.2024.
//

import UIKit

class AddListViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(saveTask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask() {
        
    }
}
