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
    
    var didReceiveSuccessResult: (([Book]) -> Void)?
    var didReceiveExpectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        
        network = BookFinderMockService()
        viewModel = MainViewModel(network)
        cancellables = []
        
        didReceiveExpectation = expectation(description: "Service")
        
        notifyPublisher()
    }
    
    override func tearDown() {
        super.tearDown()
        
        network = nil
        viewModel = nil
        cancellables = nil
        
        didReceiveSuccessResult = nil
        didReceiveExpectation = nil
    }

    func testGetBook() {
        viewModel.getBook()
        
        didReceiveSuccessResult = { result in
            XCTAssertEqual(result, MockResponses.mockBookdata.items)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testRequestNextPage() {
        viewModel.requestNextPage()
        
        didReceiveSuccessResult = { result in
            XCTAssertEqual(result, MockResponses.mockBookdata.items)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

extension BookFinderAppMainViewModelTests {
    func notifyPublisher() {
        viewModel
            .notificationPublisher
            .sink {[weak self] noti in
                guard let self = self else { return }
                switch noti {
                case .fetchData(let items):
                    self.didReceiveSuccessResult?(items)
                    self.didReceiveExpectation?.fulfill()
                }
            }
            .store(in: &cancellables)
    }
}
