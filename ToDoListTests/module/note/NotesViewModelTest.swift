//
//  NoteViewModelTest.swift
//  ToDoList
//
//  Created by Ensar on 10.10.2024.
//

import XCTest
@testable import ToDoList

final class NotesViewModelTest: XCTestCase {
    private var viewModel: NotesViewModel!
    private var mockView: MockNotesViewController!
    var mockDelegate = MockNotesViewModelDelegate()
    let textValid = "test"

    override func setUp() { //Test de gerekli nesneler
        mockView = MockNotesViewController()
        viewModel = NotesViewModel.init(row: 0, view: mockView)
        viewModel.delegate = mockDelegate
        viewModel.saveButtonTapped(text: textValid)
    }
    
    override func tearDown() { //temizlik , bellek...
        super.tearDown()
        viewModel = nil
        mockView = nil
    }
    
    func test_saveButtonTapped_textValidated() {
        
        XCTAssertEqual(mockView.isShowAlertCalled, false)
        XCTAssertEqual(mockView.isPopViewController, true)
        
        XCTAssertEqual(mockDelegate.updatedText, textValid)
        XCTAssertEqual(mockDelegate.updatedRow, 0)
    }
    
    func test_saveButtonTapped_textNotValidated() {
        XCTAssertEqual(mockView.isShowAlertCalled, false)
        XCTAssertEqual(mockView.isPopViewController, false)
        
        viewModel.saveButtonTapped(text: "") //boş metin girilir.....
        
        XCTAssertEqual(mockView.isShowAlertCalled, true)
        XCTAssertEqual(mockView.isPopViewController, false)
    }
    
    func test_deleteItem() {
        XCTAssertEqual(mockDelegate.isDeleteItemCalled, false)
        
        viewModel.deleteItem() //delete çağırtıldımı?.....
        
        XCTAssertEqual(mockDelegate.isDeleteItemCalled, true)
        XCTAssertEqual(mockDelegate.deletedRow, 0)
    }
}
