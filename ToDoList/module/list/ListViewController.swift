//
//  ListViewController.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import UIKit

protocol ListViewProtocol: AnyObject {
    func reloadData()
    func navigateToNotesViewController()
    func addButtonAction()
}

final class ListViewController: UIViewController {
    
    struct Constant {
        static let zero: Double = 0
        static let title: String = "List"
    }
    
    private var collectionView: UICollectionView!
    var viewModel: ListViewModelProtocol!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constant.title
        setupCollection()
        viewModel = ListViewModel(view: self, delegate: self)
        viewModel.viewDidLoad()
        collectionView.reloadData()
        }
    
    @objc func addButtonAction() {
        viewModel.addButtonTapped()
    }
    
    private func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: Constant.zero, left: Constant.zero, bottom: Constant.zero, right: Constant.zero)
        layout.minimumInteritemSpacing = Constant.zero
        layout.minimumLineSpacing = Constant.zero
        
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
    
    private func deleteItem(at indexPath: IndexPath) {
            viewModel.deleteItem(at: indexPath)
            collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [indexPath])
            }, completion: { _ in
                self.viewModel.saveChanges()
        })
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell else {
           
            return UICollectionViewCell()
        }
        
        let text = viewModel.cellForRowAt(at: indexPath)
        let isChecked: Bool = UserDefaultsClass.shared.get(forKey: .textSave)
        
        cell.configure(with: text, isChecked: isChecked, indexPath: indexPath)
        return cell
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return viewModel.sizeForItemAt(indexPath: indexPath, collectionViewWidth: collectionView.bounds.width)
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        func collectionView(_ collectionView: UICollectionView, trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
                        self?.deleteItem(at: indexPath)
                        completionHandler(true)
                    }
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            configuration.performsFirstActionWithFullSwipe = false
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    }
}

extension ListViewController: NotesViewControllerDelegate {
  
    func saveText(_ text: String) {
        viewModel.saveText(text)
    }
}

extension ListViewController: ListViewProtocol {
    func navigateToNotesViewController() {
        if let notesVC = self.storyboard?.instantiateViewController(ofType: NotesViewController.self) {
            notesVC.delegate = self
            navigationController?.pushViewController(notesVC, animated: true)
        }
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension ListViewController: ListViewModelDelegate {
    func setupCollectionView(with layout: UICollectionViewFlowLayout) {
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
    
    func setupAddButton(action: Selector) {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: action)
        addButton.tintColor = .black
        navigationItem.rightBarButtonItem = addButton
    }
}

