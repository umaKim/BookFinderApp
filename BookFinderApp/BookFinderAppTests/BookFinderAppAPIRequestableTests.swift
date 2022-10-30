//
//  BookFinderAppAPIRequestableTests.swift
//  BookFinderAppTests
//
//  Created by 김윤석 on 2022/10/30.
//

import XCTest
@testable import BookFinderApp

class BookFinderAppAPIRequestableTests: XCTestCase {
    
    func testHandleErrorReturnsUnkownErrorForErrorCodeNotFromTheList() {
        let networkService: BookFinderAppAPIRequestable = BookFinderMockService()
        let responseErrorCode: Int = 101
        let returnedError: APIError = networkService.handleError(from: responseErrorCode)
        
        XCTAssertTrue(returnedError == .unknownError(responseErrorCode))
    }
    
    func testHandleErrorReturnsValidationLimitRateFor422() {
        let networkService: BookFinderAppAPIRequestable = BookFinderMockService()
        let responseErrorCode: Int = 422
        let errorDescription: String = "Limit rate"
        
        let returnedError: APIError = networkService.handleError(from: responseErrorCode)
        
        XCTAssertTrue(returnedError == .validationError(errorDescription))
    }
    
    func testHandleErrorReturnsValidationUnavailableServiceFor503() {
        let networkService: BookFinderAppAPIRequestable = BookFinderMockService()
        let responseErrorCode: Int = 503
        let errorDescription: String = "Service is unavailable"
        
        let returnedError: APIError = networkService.handleError(from: responseErrorCode)
        
        XCTAssertTrue(returnedError == .validationError(errorDescription))
    }
}
