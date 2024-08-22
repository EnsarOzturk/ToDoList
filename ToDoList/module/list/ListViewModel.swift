//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    func setupAddButton(action: Selector)
}

protocol ListViewModelProtocol {
    var numberOfRows: Int { get }
    func cellForRowAt(at indexPath: IndexPath) -> ToDoItem
    func deleteItem(at indexPath: IndexPath)
    func saveText(_ text: String)
    func updateText(_ text: String, at indexPath: IndexPath)
    func viewDidLoad()
    func addButtonTapped()
    func saveChanges()
    func itemSelected(at indexPath: IndexPath, with text: String)
}

final class ListViewModel {
    
    struct Constant {
        static let systemFontSize: Double = 15
        static let maxHeight: Double = 40
        static let zero: Double = 0
    }
    
    private var items: [ToDoItem] = []
    weak var view: ListViewProtocol?
    weak var delegate: ListViewModelDelegate?
    private let userDefaultsAssistant: UserDefaultsAssistant<ToDoItem>
    
    init(view: ListViewProtocol, delegate: ListViewModelDelegate, userDefaultsKey: String) {
        self.view = view
        self.delegate = delegate
        self.userDefaultsAssistant = UserDefaultsAssistant(key: userDefaultsKey)
    }

    private func loadItems() {
        let items = UserDefaultsAssistant<ToDoItem>(key: "toDoItemsKey").loadData()
        self.items = items
        view?.reloadData()
    }
    
    private func saveToUserDefaults() {
        userDefaultsAssistant.saveData(items)
    }
    @objc private func addButtonAction() {
        view?.addButtonAction()
    }
}

extension ListViewModel: ListViewModelProtocol {
   
    var numberOfRows: Int {
        return items.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> ToDoItem {
        return items[indexPath.row]
    }

    func deleteItem(at indexPath: IndexPath) {
        let item = items.remove(at: indexPath.row)
        userDefaultsAssistant.removeData(item)
    }
    
    func updateText(_ text: String, at indexPath: IndexPath) {
        items[indexPath.row].text = text
        saveToUserDefaults()
        view?.reloadData()
    }
    
    func saveText(_ text: String) {
        let newItem = ToDoItem(text: text, isChecked: false)
        items.append(newItem)
        saveToUserDefaults()
        view?.reloadData()
    }
      
    func viewDidLoad() {
        loadItems()
        view?.reloadData()
        setupAddButton()
    }
    
    func saveChanges() {
        saveToUserDefaults()
    }
    
    func addButtonTapped() {
        view?.navigateToNotesViewController(with: nil, at: nil)
    }
    
    func itemSelected(at indexPath: IndexPath, with text: String) {
        view?.navigateToNotesViewController(with: text, at: indexPath)
    }
    
    func setupAddButton() {
        delegate?.setupAddButton(action: #selector(addButtonAction))
    }
}


