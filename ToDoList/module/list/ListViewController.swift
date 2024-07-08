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
        
        if let textSave = UserDefaults.standard.getTextArray() {
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

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
        cell.label.text = viewModel.list[indexPath.row]
        
        return cell
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = viewModel.list[indexPath.row]
        return CGSize(width: collectionView.bounds.width, height: 45)
    }
}

extension ListViewController: NotesViewControllerDelegate {
  
    func saveText(_ text: String) {
        viewModel.list.append(text)
        collectionView.reloadData()
        
        UserDefaults.standard.setTextArray(viewModel.list)
    }
}

extension String {
func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.text = self
    label.font = font
    label.sizeToFit()

    return label.frame.height
 }
}
