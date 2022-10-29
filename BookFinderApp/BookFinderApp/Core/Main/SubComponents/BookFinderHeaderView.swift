//
//  BookFinderHeaderView.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/29.
//

import Foundation
import UIKit

class BookFinderHeaderView: UICollectionReusableView {
    static let identifier = "BookFinderHeaderView"
    
    private lazy var numberOfReultsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    public func configure(with number: Int) {
        if number != 0 {
            numberOfReultsLabel.text = "Results: \(number)"
        } else {
            numberOfReultsLabel.isHidden = true
        }
    }
    
    private func setupUI() {
        backgroundColor = .systemGray6
        
        [numberOfReultsLabel].forEach { uv in
            uv.translatesAutoresizingMaskIntoConstraints = false
            addSubview(uv)
        }
        
        NSLayoutConstraint.activate([
            numberOfReultsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberOfReultsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
    public func configure(with number: Int) {
        if number != 0 {
            numberOfReultsLabel.text = "\(number)"
        } else {
            numberOfReultsLabel.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
