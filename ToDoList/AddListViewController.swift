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
  
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
}
