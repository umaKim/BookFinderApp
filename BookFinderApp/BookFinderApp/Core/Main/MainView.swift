//
//  MainView.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/28.
//

import UIKit
import Combine

class MainView: UIView {
    
    private(set) lazy var searchBarView = UISearchBar()
    private(set) lazy var listView = BookFinderListView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    public func reloadListView() {
        DispatchQueue.main.async {
            self.listView.reloadData()
        }
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        [searchBarView, listView].forEach { uv in
            uv.translatesAutoresizingMaskIntoConstraints = false
            addSubview(uv)
        }
        
        NSLayoutConstraint.activate([
            searchBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            listView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            listView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
