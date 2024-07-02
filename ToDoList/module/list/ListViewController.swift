//
//  ListViewController.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NotesViewControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    var list: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        cell.label.text = list[indexPath.row]

        return cell

    }
    
    func saveText(_ text: String) {
        list.append(text)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showNotes" {
            if let notesVC = segue.destination as? NotesViewController {
                notesVC.delegate = self
            }
        }
    }
}
