//
//  BaseView.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/28.
//

import UIKit
import Combine

protocol Actionable { }

protocol ActionPublishable {
    associatedtype T
    var actionPublisher: AnyPublisher<T, Never> { get }
}

class BaseView<T: Actionable>: UIView, ActionPublishable {
    private(set) lazy var actionPublisher: AnyPublisher<T, Never> = actionSubject.eraseToAnyPublisher()
    let actionSubject: PassthroughSubject<T, Never> = PassthroughSubject<T, Never>()
    
    var cancellables = Set<AnyCancellable>()
}
