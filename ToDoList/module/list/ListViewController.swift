//
//  ListViewController.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    private var viewModel = ListViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "list"
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        
        if let textSave = UserDefaults.standard.stringArray(forKey: "textSave") {
             viewModel.list = textSave
            
         }
        
         collectionView.reloadData()
        }
   
    @IBAction func notesToggleButtonTapped(_ sender: UIBarButtonItem) {
        if let notesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotesViewController")
                                                                                            as? NotesViewController {
            notesVC.delegate = self
            navigationController?.pushViewController(notesVC, animated: true)
        }
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
        cell.label.text = viewModel.list[indexPath.row]
        
        return cell
    }
}

extension ListViewController: UICollectionViewDelegate {
    
}

extension ListViewController: NotesViewControllerDelegate {
  
    func saveText(_ text: String) {
        viewModel.list.append(text)
        collectionView.reloadData()
        
        UserDefaults.standard.set(viewModel.list, forKey: "textSave")
    }
}

