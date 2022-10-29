//
//  MainViewModel.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/28.
//

import Combine
import Foundation

enum MainViewModelNotification: Notifiable {
    case fetchData([Book])
}

class MainViewModel: BaseViewModel<MainViewModelNotification> {
    
    private(set) var books: [Book] = []
    
    private var page = 0
    
    private let network: BookFinderAppAPIRequestable
    
    private var isSearching: Bool = false
    
    init(
        _ network: BookFinderAppAPIRequestable = NetworkService()
    ) {
        self.network = network
        super.init()
    }
    
    private var bookTitle: String = ""
    
    func setBookTitle(as title: String) {
        self.bookTitle = title
    }
    
    func getBook() {
        isSearching = true
        isLoadingSubject.send(true)
        network
            .getBook(of: bookTitle, page: page)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                guard let self = self else {return }
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.errorSubject.send(error)
                }
                self.isLoadingSubject.send(false)
                self.isSearching = false
            } receiveValue: {[weak self] result in
                guard let self = self else { return }
                self.books.append(contentsOf: result.items)
                self.notificationSubject.send(.fetchData(self.books))
            }
            .store(in: &cancellables)
    }
    
    func requestNextPage() {
        if isSearching == false {
            self.page += 1
            self.getBook()
        }
    }
}
