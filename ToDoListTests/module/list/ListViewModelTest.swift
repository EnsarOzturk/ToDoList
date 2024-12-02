//
//  ListViewModelTest.swift
//  ToDoListTests
//
//  Created by Ensar on 11.10.2024.
//

import XCTest
@testable import ToDoList

final class ListViewModelTest: XCTestCase {
    
    var mockView: MockListViewController!
    var viewModel: ListViewModel!
    var mockDelegate: MockListViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        mockView = MockListViewController()
        mockDelegate = MockListViewModelDelegate()
        viewModel = ListViewModel(view: mockView, delegate: mockDelegate)
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        viewModel = nil
        mockDelegate = nil
    }
    
    func testLoadItemsReloadDataCalled() {
        viewModel.viewDidLoad()
        XCTAssertEqual(mockView.reloadDataCalled, true)
    }
    
    func testAddButtonTappedNavigatesToNotesViewController() {
        viewModel.addButtonTapped()
        XCTAssertEqual(mockView.navigateCalled, true)
    }
    
    func testAddItem() {
        viewModel.saveText("new task", at: nil)
        XCTAssertEqual(viewModel.numberOfRows, 1)
    }
    
    func testDeleteItem() {
        viewModel.saveText("task delete", at: nil)
        viewModel.deleteItem(at: 0)
        XCTAssertEqual(viewModel.numberOfRows, 0)
    }
    
    func testSaveToUserDefaults() {
        viewModel.saveText("new task", at: nil)
        XCTAssertEqual(viewModel.numberOfRows, 1)
    }
}
