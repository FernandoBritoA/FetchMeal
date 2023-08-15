//
//  BulletPointView.swift
//  FetchMeal
//
//  Created by Fernando Brito on 14/08/23.
//

import UIKit

class BulletPointView: UIView {
    private let bulletImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.tintColor = .black
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let bulletLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(bulletImageView)
        addSubview(bulletLabel)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        configureConstraints()
    }

    public func configure(with text: String) {
        bulletLabel.text = text
    }

    private func configureConstraints() {
        let spacing = 5.0
        let bulletImageViewConstraints = [
            bulletImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bulletImageView.heightAnchor.constraint(equalToConstant: 6),
            bulletImageView.widthAnchor.constraint(equalToConstant: 6),
            bulletImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]

        let bulletLabelConstraints = [
            bulletLabel.topAnchor.constraint(equalTo: topAnchor),
            bulletLabel.leadingAnchor.constraint(equalTo: bulletImageView.trailingAnchor, constant: spacing),
            bulletLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            bulletLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]

        NSLayoutConstraint.activate(bulletImageViewConstraints + bulletLabelConstraints)
    }
}
