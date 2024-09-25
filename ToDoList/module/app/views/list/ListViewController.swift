//
//  ListViewController.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import UIKit

protocol ListViewProtocol: AnyObject {
    func reloadData()
    func navigateToNotesViewController(with text: String?, at indexPath: IndexPath?)
    func addButtonAction()
    func setupCollectionView(with layout: UICollectionViewFlowLayout)
}

final class ListViewController: UIViewController {
    
    struct Constant {
        static let zero: Double = 0
        static let title: String = "List"
    }
    
    private var collectionView: UICollectionView!
    var viewModel: ListViewModelProtocol!
    private let UserDefaults = UserDefaultsAssistant<ToDoItem>()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constant.title
        let layout = setupLayout()
        setupCollectionView(with: layout)
        viewModel = ListViewModel(view: self, delegate: self)
        viewModel.viewDidLoad()
        reloadData()
    }
    
    private func setupLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: Constant.zero, left: Constant.zero, bottom: Constant.zero, right: Constant.zero)
        layout.minimumInteritemSpacing = Constant.zero
        layout.minimumLineSpacing = Constant.zero
        return layout
    }
    
    @objc func addButtonAction() {
        viewModel.addButtonTapped()
    }
    
    internal func deleteItem(at indexPath: IndexPath) {
        viewModel.deleteItem(at: indexPath.row)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.identifier, for: indexPath) as? ListCell else {
            return UICollectionViewCell()
        }
        
        let item = viewModel.cellForRowAt(at: indexPath)
        cell.configure(with: item.text, isChecked: item.isChecked, indexPath: indexPath)
        return cell
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 30)
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = viewModel.cellForRowAt(at: indexPath)
        viewModel.itemSelected(at: indexPath, with: item.text)
    }
}

extension ListViewController: NotesViewControllerDelegate {
    func deleteItem(at row: Int?) {
        if let row = row {
            viewModel.deleteItem(at: row)
            collectionView.performBatchUpdates( {
                collectionView.deleteItems(at: [IndexPath(row: row, section: 0)])
            }, completion: { _ in
                self.viewModel.saveChanges()
            })
        }
    }
    
    func saveText(_ text: String, at row: Int?) {
        if let row = row {
            viewModel.updateText(text, at: row)
        } else {
            viewModel.saveText(text)
        }
    }
}

extension ListViewController: ListViewProtocol {
    func navigateToNotesViewController(with text: String?, at indexPath: IndexPath?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let notesVC = storyboard.instantiateViewController(withIdentifier: "NotesViewController") as? NotesViewController {
                notesVC.delegate = self
                notesVC.indexPath = indexPath
                notesVC.initialText = text
                navigationController?.pushViewController(notesVC, animated: true)
            } else {
        }
    }
   
    func reloadData() {
        collectionView.reloadData()
    }
    
    func setupCollectionView(with layout: UICollectionViewFlowLayout) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.identifier)
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

extension ListViewController: ListViewModelDelegate {
    func setupAddButton(action: Selector) {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: action)
        addButton.tintColor = .black
        navigationItem.rightBarButtonItem = addButton
    }
}

