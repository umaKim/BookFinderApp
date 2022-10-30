//
//  URLRequestableTests.swift
//  BookFinderAppTests
//
//  Created by 김윤석 on 2022/10/30.
//

import XCTest
@testable import BookFinderApp

final class URLRequestableTests: XCTestCase {
    
    private struct MockService: APIRequestable {
        
        var session: URLSession
        
        func handleError(from response: Int) -> BookFinderApp.APIError {
            .invalidRequest
        }
    }

    func testExample() {
        let service = MockService(session: URLSession(configuration: .default))
        
        let query: String = "Mock"
        let page: Int = 0
        
        let request = service.createRequest(from: BookFinderAppRequest.getBook(query, page))
        
        let expectedString: String = ""
        
        XCTAssertEqual(request?.url?.absoluteString, expectedString)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
