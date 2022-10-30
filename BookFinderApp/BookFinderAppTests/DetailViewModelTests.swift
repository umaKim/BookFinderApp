//
//  DetailViewModelTests.swift
//  BookFinderAppTests
//
//  Created by 김윤석 on 2022/10/30.
//

import XCTest
@testable import BookFinderApp

final class DetailViewModelTests: XCTestCase {
    
    let book = MockResponses.mockBookdata.items[0]
    var viewModel: DetailViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = DetailViewModel(book)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testBook() {
        XCTAssertEqual(viewModel.book, self.book)
    }
}
