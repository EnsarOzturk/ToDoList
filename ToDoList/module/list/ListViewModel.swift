//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import Foundation
import UIKit

protocol ListViewModelDelegate: AnyObject {
    func setupAddButton(action: Selector)
}

protocol ListViewModelProtocol {
    var numberOfRows: Int { get }
    func cellForRowAt(at indexPath: IndexPath) -> String
    func deleteIndex(at indexPath: IndexPath)
    func saveText(_ text: String)
    func viewDidLoad()
    func addButtonTapped()
    func sizeForItemAt(indexPath: IndexPath, collectionViewWidth: CGFloat) -> CGSize
    func deleteItem(at indexPath: IndexPath)
    func saveChanges()
}

final class ListViewModel: ListViewModelProtocol {
    func deleteItem(at indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        let key = UserDefaultsKey.itemState(indexPath: indexPath)
        UserDefaultsClass.shared.remove(forKey: key)
    }
    
    func saveChanges() {
        
        for (index, item) in items.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            let key = UserDefaultsKey.itemState(indexPath: indexPath)
            UserDefaultsClass.shared.set(true, forKey: key)
        }
    }
    
    
    struct Constant {
        static let systemFontSize: Double = 15
        static let maxHeight: Double = 70
    }
            
    private var list: [String] = []
    private var items: [String] = []
    weak var view: ListViewProtocol?
    weak var delegate: ListViewModelDelegate?
    private let userDefaultsClass = UserDefaultsClass.shared
    
    init(view: ListViewProtocol, delegate: ListViewModelDelegate) {
        self.view = view
        self.delegate = delegate
    }
    
    var numberOfRows: Int {
        return list.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> String {
        list[indexPath.row]
    }
    
    func deleteIndex(at indexPath: IndexPath) {
        list.remove(at: indexPath.item)
        saveToUserDefaults()
    }
    
    func viewDidLoad() {
        getTextArray()
        view?.reloadData()
        setupAddButton()
    }
    
    private func getTextArray() {
        if let textSave: [String]  = userDefaultsClass.get(forKey: .textSave) {
            list = textSave
        }
    }
    
    func saveText(_ text: String) {
        list.append(text)
        saveToUserDefaults()
        view?.reloadData()
       }
    
    func sizeForItemAt(indexPath: IndexPath, collectionViewWidth: CGFloat) -> CGSize {
        let item = cellForRowAt(at: indexPath)
        let font = UIFont.systemFont(ofSize: Constant.systemFontSize)
        let height = item.height(constraintedWidth: collectionViewWidth, font: font)
        return CGSize(width: collectionViewWidth, height: max(height, Constant.maxHeight))
    }
    
    
    func addButtonTapped() {
        view?.navigateToNotesViewController()
    }
    
    func setupAddButton() {
        delegate?.setupAddButton(action: #selector(addButtonAction))
    }
    
    @objc private func addButtonAction() {
            view?.addButtonAction()
        }
    
    private func saveToUserDefaults() {
        userDefaultsClass.set(list, forKey: .textSave)
    }
}
