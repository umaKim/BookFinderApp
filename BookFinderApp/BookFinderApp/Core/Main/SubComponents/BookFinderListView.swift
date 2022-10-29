//
//  BookFinderListView.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/29.
//

import UIKit

class BookFinderListView: UITableView {
    
    private let headerView = BookFinderHeaderView(
        frame: CGRect(
            origin: .zero,
            size: CGSize(width: UIScreen.main.bounds.width, height: 50)
        )
    )
    
    public func configureHeaderView(with count: Int){
        headerView.configure(with: count)
    }
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.register(
            BookFinderListViewCell.self,
            forCellReuseIdentifier: BookFinderListViewCell.identifier
        )
        self.rowHeight = 100
        self.tableHeaderView = headerView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
