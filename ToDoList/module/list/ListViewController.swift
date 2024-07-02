//
//  ListViewController.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    private var viewModel = ListViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "list"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        cell.label.text = viewModel.list[indexPath.row]

        return cell
    }
   
    @IBAction func notesToggleButtonTapped(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let notesVC = storyboard.instantiateViewController(withIdentifier: "NotesViewController") as? NotesViewController {
            
            notesVC.delegate = self
            navigationController?.pushViewController(notesVC, animated: true)
        }
    }
}

extension ListViewController: NotesViewControllerDelegate {
  
    func saveText(_ text: String) {
        viewModel.list.append(text)
        tableView.reloadData()
    }
}

