//
//  UIView+Ext.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/29.
//

import UIKit

extension UIView {
    func setUpStackView(
        with subViews: [UIView],
        axis: NSLayoutConstraint.Axis = .vertical,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill
    ) -> UIView {
        let sv = UIStackView(arrangedSubviews: subViews)
        sv.axis = axis
        sv.alignment = .leading
        sv.distribution = .fill
        sv.spacing = 6
        
        return sv
    }
}
