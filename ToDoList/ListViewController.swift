//
//  ListViewController.swift
//  ToDoList
//
//  Created by Ensar on 27.02.2024.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ToDoList"
    }


}
