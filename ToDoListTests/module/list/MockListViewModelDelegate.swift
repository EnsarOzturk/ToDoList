//
//  MockListViewModelDelegate.swift
//  ToDoListTests
//
//  Created by Ensar on 14.10.2024.
//
import Foundation
@testable import ToDoList

class MockListViewModelDelegate: ListViewModelDelegate {
    var setupAddButtonCalled = false
    
    func setupAddButton(action: Selector) {
        setupAddButtonCalled = true
    }
}
