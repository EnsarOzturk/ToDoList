//
//  MockNotesViewController.swift
//  ToDoListTests
//
//  Created by Ensar on 11.10.2024.
//

import Foundation
@testable import ToDoList

class MockNotesViewController: NotesViewControllerProtocol {
    
    var isDisplayAlertWithTitle: Bool = false
    func displayAlert(title: String, message: String) {
        isDisplayAlertWithTitle = true
    }
    
    func displayAlert(message: String) {
        //
    }
    
    func displayFailureAlert(message: String?) {
        //
    }
    
    func displayAlertWithAction(title: String?, message: String?, action: ToDoList.AlertAction?) {
        //
    }
    //sahte NotesViewControllerProtocol
    var isShowAlertCalled: Bool = false
    var isPopViewController: Bool = false
    
    func showAlert() {
        isShowAlertCalled = true
    }
    
    func popViewController() {
        isPopViewController = true
    }
}
