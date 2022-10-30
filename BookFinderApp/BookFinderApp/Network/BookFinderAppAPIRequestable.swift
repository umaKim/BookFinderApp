//
//  BookFinderAppAPIRequestable.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/30.
//

import Foundation
import Combine

protocol BookFinderAppAPIRequestable: APIRequestable {
    func getBook(of title: String, page: Int) -> AnyPublisher<BookResponse, APIError>
}

extension BookFinderAppAPIRequestable {
    func handleError(from response: Int) -> APIError {
        guard let responseError = ResponseError(rawValue: response) else {
          return .unknownError(response)
        }
        
        switch responseError {
        case .notModified:
          return .invalidResponse
        case .validationFailed:
          return .validationError("Limit rate")
        case .serviceUnavailable:
          return .validationError("Service is unavailable")
        }
    }
}

enum ResponseError: Int {
  case notModified = 304
  case validationFailed = 422
  case serviceUnavailable = 503
}
