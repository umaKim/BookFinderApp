//
//  NetworkService.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/28.
//

import Foundation
import Combine

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case delete = "DELETE"
  case put = "PUT"
}

protocol URLRequestable {
  var baseURL: String { get }
  var method: HTTPMethod { get }
  var endPoint: String { get }
  var httpBody: Data? { get }
  var httpHeaders: [String: String]? { get }
}

enum BookFinderAppRequest {
    case getBook(String)
}

extension BookFinderAppRequest: URLRequestable {
    var baseURL: String {
        BaseUrl.url
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var endPoint: String {
        switch self {
        case .getBook(let query):
            return "v1/volumes?q=\(query)"
        }
    }
    
    var httpBody: Data? {
        nil
    }
    
    var httpHeaders: [String : String]? {
        nil
    }
}

enum BaseUrl {
    static let url = "https://www.googleapis.com/books"
}

struct NetworkService: BookFinderAppAPIRequestable {
    
    var session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
      self.session = session
    }
    
    func getBook(of title: String) -> AnyPublisher<BookResponse, APIError> {
        guard
            let request = self.createRequest(from: BookFinderAppRequest.getBook(title))
        else {
          return Fail(error: APIError.invalidRequest).eraseToAnyPublisher()
        }
        
        return self.request(request: request, response: BookResponse.self)
    }
}
