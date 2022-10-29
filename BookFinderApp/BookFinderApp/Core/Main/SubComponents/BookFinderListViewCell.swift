//
//  BookFinderListViewCell.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/29.
//

import UIKit
import Combine

class BookFinderListViewCell: UITableViewCell {
    static let identifier = "ListViewCell"
    
    private lazy var content = defaultContentConfiguration()
    
    private let bookImageView: UIImageView = {
       let uv = UIImageView()
        uv.heightAnchor.constraint(equalToConstant: 90).isActive = true
        uv.widthAnchor.constraint(equalToConstant: 90).isActive = true
        return uv
    }()
    private let titleLabel = UILabel()
    private let autherLabel = UILabel()
    private let publishedDateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        setupUI()
    }
    
    private func setupUI() {
        let verticalSv = setUpStackView(with: [titleLabel, autherLabel, publishedDateLabel], alignment: .leading)
        let horizontalSv = setUpStackView(with: [bookImageView, verticalSv], axis: .horizontal)
        
        [horizontalSv].forEach { uv in
            uv.translatesAutoresizingMaskIntoConstraints = false
            addSubview(uv)
        }

        NSLayoutConstraint.activate([
            horizontalSv.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            horizontalSv.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            horizontalSv.topAnchor.constraint(equalTo: topAnchor),
            horizontalSv.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private var cancellables: Set<AnyCancellable> = []
        
    public func configure(with book: Book) {
        ImageProvider.shared.loadImage(from: book.volumeInfo.imageLinks?.thumbnail ?? "") { [weak self] result in
            DispatchQueue.main.async {
                self?.bookImageView.image = try? result.get()
            }
        }
        
        titleLabel.text         = book.volumeInfo.title
        autherLabel.text        = book.volumeInfo.authors?.joined(separator: ",")
        publishedDateLabel.text = book.volumeInfo.publishedDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

