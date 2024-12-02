//
//  MockListViewController.swift
//  ToDoListTests
//
//  Created by Ensar on 14.10.2024.

import XCTest
@testable import ToDoList

class MockListViewController: ListViewControllerProtocol {
    var reloadDataCalled = false
    var navigateCalled = false
    var addedButtonActionCalled = false
    
    func reloadData() {
        reloadDataCalled = true
    }
    
    func navigateToNotesViewController(with text: String?, at indexPath: IndexPath?) {
        navigateCalled = true
    }
    
    func addButtonAction() {
        addedButtonActionCalled = true
    }
}


