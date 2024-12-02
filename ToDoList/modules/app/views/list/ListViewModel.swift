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
    var notesViewModelDelegate: NotesViewModelDelegate { get }
    var numberOfRows: Int { get }
    func cellForRowAt(row: Int) -> ToDoItem
    func deleteItem(at row: Int)
    func saveText(_ text: String, at row: Int?)
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
        static let key: String = "toDoItemsKey"
    }
    
    private var items: [ToDoItem] = []
    weak var view: ListViewControllerProtocol?
    weak var delegate: ListViewModelDelegate?
    private var userDefaultsAssistant: UserDefaultsAssistant<ToDoItem>
    
    init(view: ListViewControllerProtocol, delegate: ListViewModelDelegate) {
        self.view = view
        self.delegate = delegate
        self.userDefaultsAssistant = UserDefaultsAssistant<ToDoItem>()
    }

    private func loadItems() {
        let items = userDefaultsAssistant.loadData(forKey: Constant.key)
        self.items = items
        view?.reloadData()
    }
    
    private func saveToUserDefaults() {
        userDefaultsAssistant.saveData(items, forKey: Constant.key)
    }
    
    @objc private func addButtonAction() {
        view?.addButtonAction()
    }
}

extension ListViewModel: ListViewModelProtocol {
    var notesViewModelDelegate: NotesViewModelDelegate {
        self
    }
    
    var numberOfRows: Int {
        items.count
    }
    
    func cellForRowAt(row: Int)-> ToDoItem {
        items[row]
    }

    func deleteItem(at row: Int) {
        let item = items.remove(at: row)
        userDefaultsAssistant.removeData(item, forKey: Constant.key)
    }
    
    private func updateText(_ text: String, at row: Int) {
        items[row].text = text
        saveToUserDefaults()
        view?.reloadData()
    }
    
    private func saveText(_ text: String) {
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
    
    func saveText(_ text: String, at row: Int?) {
        if let row = row {
            updateText(text, at: row)
        } else {
            saveText(text)
        }
    }
}

extension ListViewModel: NotesViewModelDelegate {
    func deleteItem(at row: Int?) {
        if let row = row {
            deleteItem(at: row)
            view?.reloadData()
        }
    }
    
    func updateText(_ text: String, at row: Int?) {
        saveText(text, at: row)
    }
}
