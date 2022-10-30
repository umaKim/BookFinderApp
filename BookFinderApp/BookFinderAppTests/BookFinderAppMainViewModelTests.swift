//
//  BookFinderAppMainViewModelTests.swift
//  BookFinderAppTests
//
//  Created by 김윤석 on 2022/10/28.
//
import Combine
import XCTest
@testable import BookFinderApp

final class BookFinderAppMainViewModelTests: XCTestCase {
    
    private var viewModel: MainViewModel!
    private var network: BookFinderMockService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        network = BookFinderMockService()
        viewModel = MainViewModel(network)
        cancellables = []
    }
    
    override func tearDown() {
        super.tearDown()
        
        network = nil
        viewModel = nil
        cancellables = nil
    }

    func testExample() throws {
        let expectation = self.expectation(description: "Service")
        
        var books: [Book] = []
        
        viewModel
            .notificationPublisher
            .sink { noti in
                switch noti {
                case .fetchData(let items):
                    books = items
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.getBook()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(books, MockResponses.mockBookdata.items)
    }
    
    func testPagination() {
        let expectation = self.expectation(description: "Service")
        
        var books: [Book] = []
        
        viewModel
            .notificationPublisher
            .sink { noti in
                switch noti {
                case .fetchData(let items):
                    books = items
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.requestNextPage()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(books, MockResponses.mockBookdata.items)
    }
}
