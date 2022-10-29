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
    
    private let network: BookFinderAppAPIRequestable
    
    init(
        _ network: BookFinderAppAPIRequestable = NetworkService()
    ) {
        self.network = network
        super.init()
    }
    
    func getBook(of title: String) {
        isLoadingSubject.send(true)
        network
            .getBook(of: title)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.errorSubject.send(error)
                }
                self?.isLoadingSubject.send(false)
            } receiveValue: {[weak self] result in
                self?.books = result.items
                self?.notificationSubject.send(.fetchData(result.items))
            }
            .store(in: &cancellables)
    }
}
