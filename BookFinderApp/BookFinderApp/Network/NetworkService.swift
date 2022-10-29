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

typealias ImageProviderResult = (Result<UIImage, APIError>) -> Void

struct ImageProvider {
    static let shared = ImageProvider(URLSession.shared)
    
    private let cache = NSCache<NSString, UIImage>()
    
    private let session: URLSession
    
    private init(
        _ session: URLSession
    ) {
        self.session = session
    }
    
    public func loadImage(from urlString: String, completion: ImageProviderResult? = nil) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey){
            completion?(.success(image))
        }
        
        guard
            let url = URL(string: urlString)
        else {
            completion?(.success(UIImage()))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)
            else {
                completion?(.failure(.invalidResponse))
                return
            }
            
            cache.setObject(image, forKey: cacheKey)
            
            completion?(.success(image))
        }.resume()
    }
}
