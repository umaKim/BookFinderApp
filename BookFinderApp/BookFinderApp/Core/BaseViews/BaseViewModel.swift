//
//  BaseViewModel.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/28.
//

import Foundation
import Combine

protocol Notifiable {}

protocol NotificationPublishable {
    associatedtype T
    var notificationPublisher: AnyPublisher<T, Never> { get }
}

protocol ViewModel {
    var isLoadingPublisher: AnyPublisher<Bool, Never> { get }
    var errorPublisher: AnyPublisher<Error, Never> { get }

    func onViewDidLoad()
    func onViewWillAppear()
    func onViewDidAppear()
    func onViewWillDisappear()
    func onViewDidDisappear()
}

class BaseViewModel<T: Notifiable>: ViewModel, NotificationPublishable {
    private(set) lazy var notificationPublisher = notificationSubject.eraseToAnyPublisher()
    let notificationSubject = PassthroughSubject<T, Never>()
    
    private(set) lazy var isLoadingPublisher = isLoadingSubject.eraseToAnyPublisher()
    let isLoadingSubject = PassthroughSubject<Bool, Never>()

    private(set) lazy var errorPublisher = errorSubject.eraseToAnyPublisher()
    let errorSubject = PassthroughSubject<Error, Never>()
    
    var cancellables = Set<AnyCancellable>()
    
    deinit {
        debugPrint("deinit of ", String(describing: self))
    }

    func onViewDidLoad() {}
    func onViewWillAppear() {}
    func onViewDidAppear() {}
    func onViewWillDisappear() {}
    func onViewDidDisappear() {}
}
