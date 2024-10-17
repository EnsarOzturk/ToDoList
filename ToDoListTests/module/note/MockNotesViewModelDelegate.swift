//
//  MockNotesViewModelDelegate.swift
//  ToDoListTests
//
//  Created by Ensar on 11.10.2024.
//
import Foundation
@testable import ToDoList
// viewModel - delegate
class MockNotesViewModelDelegate: NotesViewModelDelegate { //sahte NotesViewModelDelegate
    var updatedText: String?
    var updatedRow: Int?
    var isDeleteItemCalled: Bool = false
    var deletedRow: Int?
    
    func updateText(_ text: String, at row: Int?) {
        updatedText = text
        updatedRow = row
    }
    
    func deleteItem(at row: Int?) {
        isDeleteItemCalled = true
        deletedRow = row
    }
}
