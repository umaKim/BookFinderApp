//
//  DetailView.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/28.
//

import UIKit

class DetailView: UIView {

    private let imageView: UIImageView = {
        let uv = UIImageView()
        uv.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.5).isActive = true
        uv.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.5).isActive = true
        uv.image = UIImage(systemName: "book.closed")
        uv.backgroundColor = .white
        return uv
    }()
    private let titleLabel = UILabel()
    private let autherLabel = UILabel()
    private let publishedDateLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    public func configure(with book: Book) {
        ImageProvider.shared.loadImage(from: book.volumeInfo.imageLinks?.thumbnail ?? "") { [weak self] result in
            DispatchQueue.main.async {
                self?.imageView.image = try? result.get()
            }
        }
        titleLabel.text = book.volumeInfo.title
        autherLabel.text = book.volumeInfo.authors?.joined(separator: " , ")
        publishedDateLabel.text = book.volumeInfo.publishedDate
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        let sv = setUpStackView(with: [imageView, titleLabel, autherLabel, publishedDateLabel], axis: .vertical, alignment: .center, distribution: .fill)
        
        [sv].forEach { uv in
            uv.translatesAutoresizingMaskIntoConstraints = false
            addSubview(uv)
        }
        
        NSLayoutConstraint.activate([
            sv.centerXAnchor.constraint(equalTo: centerXAnchor),
            sv.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
