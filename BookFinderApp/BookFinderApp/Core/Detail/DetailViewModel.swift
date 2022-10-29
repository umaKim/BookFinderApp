//
//  DetailViewModel.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/28.
//

import Foundation

enum DetailViewModelNotification: Notifiable {
    
}

class DetailViewModel: BaseViewModel<DetailViewModelNotification> {
    
    private(set) var book: Book
    
    init(_ book: Book) {
        self.book = book
        super.init()
    }
}
