//
//  MockNotesViewController.swift
//  ToDoListTests
//
//  Created by Ensar on 11.10.2024.
//

import Foundation
@testable import ToDoList

class MockNotesViewController: NotesViewControllerProtocol { //sahte NotesViewControllerProtocol
    var isShowAlertCalled: Bool = false
    var isPopViewController: Bool = false
    
    func showAlert() {
        isShowAlertCalled = true
    }
    
    func popViewController() {
        isPopViewController = true
    }
}
