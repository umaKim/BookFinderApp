//
//  BookFinderAppTests.swift
//  BookFinderAppTests
//
//  Created by 김윤석 on 2022/10/28.
//
import Combine
import XCTest
@testable import BookFinderApp

final class BookFinderAppTests: XCTestCase {
    
    private var viewModel: MainViewModel!
    private var network: BookFinderMockService!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        
        network = BookFinderMockService()
        viewModel = MainViewModel(network)
    }
    
    override func tearDown() {
        super.tearDown()
        
        network = nil
        viewModel = nil
    }

    func testExample() throws {
        viewModel.getBook(of: "Mock")
        
        viewModel
            .notificationPublisher
            .sink { noti in
                switch noti {
                case .fetchData(let books):
                    XCTAssertEqual(books, MockResponses.mockBookdata.items)
                }
            }
            .store(in: &cancellables)
    }
}
