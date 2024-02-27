//
//  ListViewController.swift
//  ToDoList
//
//  Created by Ensar on 27.02.2024.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TO DO LIST"
        self.navigationController?.navigationBar.tintColor = .black
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    
}
