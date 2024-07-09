//
//  ListViewController.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import UIKit

final class ListViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var viewModel:  ListViewModelProtocol = ListViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "list"
        setupCollection()
        setupNavigationItem()
        viewModel.viewDidLoad()
        collectionView.reloadData()
        }
    
    private func setupNavigationItem() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(notesToggleButtonTapped(_:)))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func notesToggleButtonTapped(_ sender: UIBarButtonItem) {
        if let notesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotesViewController")
                                                                                            as? NotesViewController {
            notesVC.delegate = self
            navigationController?.pushViewController(notesVC, animated: true)
        }
    }
    
    private func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell else {
           
            return UICollectionViewCell()
        }
        
        let text = viewModel.cellForRowAt(at: indexPath)
        cell.configure(with: text)
        
        return cell
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = viewModel.cellForRowAt(at: indexPath)
        let font = UIFont.systemFont(ofSize: 15)
        let height = item.height(constraintedWidth: collectionView.bounds.width, font: font)
        return CGSize(width: collectionView.bounds.width, height: max(height, 70))
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.deleteIndex(at: indexPath)
        print("select")
        collectionView.reloadData()
    }
}

extension ListViewController: NotesViewControllerDelegate {
  
    func saveText(_ text: String) {
        viewModel.saveText(text)
        collectionView.reloadData()
    }
}

