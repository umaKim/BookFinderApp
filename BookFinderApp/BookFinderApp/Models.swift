//
//  Models.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/28.
//

import Foundation

struct BookResponse: Decodable, Equatable {
    var items: [Book]
    var totalItems: Int
}

struct Book: Decodable, Equatable, Identifiable {
    var id: String
    var volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable, Equatable {
    var title: String
    var authors: [String]?
    var publishedDate: String?
    var imageLinks: ImageLinks?
}

struct ImageLinks: Decodable, Equatable {
    var smallThumbnail: String
    var thumbnail: String
}

protocol MainViewModelProtocol {
    var network: BookFinderAppAPIRequestable { get }
    var books: [Book] { get }
    func getBook(of title: String)
}
