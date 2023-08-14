//
//  BulletPointsStackView.swift
//  FetchMeal
//
//  Created by Fernando Brito on 14/08/23.
//

import UIKit

class BulletPointsStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        spacing = 5
        axis = .vertical
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    public func configure(with strArr: [String]) {
        for text in strArr {
            let bulletPoint = BulletPointView()
            bulletPoint.configure(with: text)

            addArrangedSubview(bulletPoint)
        }
    }
}
