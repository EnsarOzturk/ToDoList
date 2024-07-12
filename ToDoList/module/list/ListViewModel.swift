//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Ensar on 1.07.2024.
//

import Foundation

protocol ListViewModelProtocol {
    var numberOfRows: Int { get }
    func cellForRowAt(at indexPath: IndexPath) -> String
    func deleteIndex(at indexPath: IndexPath)
    func saveText(_ text: String)
    func viewDidLoad()
}

class ListViewModel: ListViewModelProtocol {
        
    private var list: [String] = []
    weak var view: ListViewProtocol?
    
    init(view: ListViewProtocol) {
        self.view = view
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
    }
    
    private func getTextArray() {
        if let textSave = UserDefaults.standard.getTextArray() {
            list = textSave
        }
    }
    
    func saveText(_ text: String) {
        list.append(text)
        saveToUserDefaults()
        view?.reloadData()
       }
    
    private func saveToUserDefaults() {
        UserDefaults.standard.set(list, forKey: "TextArray")
    }
}
