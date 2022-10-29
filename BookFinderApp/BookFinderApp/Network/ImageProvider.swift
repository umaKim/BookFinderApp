//
//  ImageProvider.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/29.
//

import UIKit

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
