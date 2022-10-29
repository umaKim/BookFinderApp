//
//  DetailViewController.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/28.
//

import UIKit

class DetailViewController: BaseViewController<DetailViewModel> {

    private let contentView = DetailView()
    
    override func loadView() {
        super.loadView()
        
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.configure(with: viewModel.book)
    }
}
