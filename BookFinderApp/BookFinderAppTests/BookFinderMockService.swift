//
//  BookFinderMockService.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/29.
//
 
import Combine
import Foundation
@testable import BookFinderApp
 
struct BookFinderMockService: BookFinderAppAPIRequestable {
    func getBook(of title: String) -> AnyPublisher<BookResponse, APIError> {
        return Just(MockResponses.mockBookdata)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
 
    internal var session: URLSession
 
    init(session: URLSession = URLSession(configuration: .default)) {
      self.session = session
    }
}
 
enum MockResponses {
    static let mockBookdata: BookResponse = Bundle.main.decode(BookResponse.self, from: "MockResponse.json")
}
