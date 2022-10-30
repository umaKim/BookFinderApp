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
    var didReceiveError: ((Error) -> Void)?
    var didReceiveIsLoading: ((Bool)-> Void)?
    var didReceiveExpectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        
        network = BookFinderMockService()
        viewModel = MainViewModel(network)
        cancellables = []
        
        didReceiveExpectation = expectation(description: "Service")
        
        setupNotifyPublisher()
        setupErrorPublisher()
        setupIsLoadingPublisher()
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
    
    func testDefaultError() {
        viewModel.errorSubject.send(APIError.defaultError("DefaultError", 0))
        
        didReceiveError = { error in
            print(error)
            XCTAssertEqual(error as! APIError, APIError.defaultError("DefaultError", 0))
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testInvalidJsonError() {
        viewModel.errorSubject.send(APIError.invalidJson("InvalidJson"))
        
        didReceiveError = { error in
            print(error)
            XCTAssertEqual(error as! APIError, APIError.invalidJson("InvalidJson"))
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testInvalidRequestError() {
        viewModel.errorSubject.send(APIError.invalidRequest)
        
        didReceiveError = { error in
            print(error)
            XCTAssertEqual(error as! APIError, APIError.invalidRequest)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testInvalidResponseError() {
        viewModel.errorSubject.send(APIError.invalidResponse)
        
        didReceiveError = { error in
            print(error)
            XCTAssertEqual(error as! APIError, APIError.invalidResponse)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testUnknownError() {
        viewModel.errorSubject.send(APIError.unknownError(500))
        
        didReceiveError = { error in
            print(error)
            XCTAssertEqual(error as! APIError, APIError.unknownError(500))
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testValidationError() {
        viewModel.errorSubject.send(APIError.validationError("ValidationError"))
        
        didReceiveError = { error in
            print(error)
            XCTAssertEqual(error as! APIError, APIError.validationError("ValidationError"))
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testIsLoadingTrue() {
        viewModel.isLoadingSubject.send(true)
        
        didReceiveIsLoading = { isLoading in
            XCTAssertTrue(isLoading)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testIsLoadingFalse() {
        viewModel.isLoadingSubject.send(false)
        
        didReceiveIsLoading = { isLoading in
            XCTAssertFalse(isLoading)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

extension BookFinderAppMainViewModelTests {
    func setupNotifyPublisher() {
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
    
    func setupErrorPublisher() {
        viewModel
            .errorPublisher
            .sink {[weak self] error in
                guard let self = self else { return }
                self.didReceiveError?(error)
                self.didReceiveExpectation?.fulfill()
            }
            .store(in: &cancellables)
    }
    
    func setupIsLoadingPublisher() {
        viewModel
            .isLoadingPublisher
            .sink {[weak self] isLoading in
                guard let self = self else { return }
                self.didReceiveIsLoading?(isLoading)
                self.didReceiveExpectation?.fulfill()
            }
            .store(in: &cancellables)
    }
}
