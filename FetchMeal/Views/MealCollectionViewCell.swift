//
//  MealCollectionViewCell.swift
//  FetchMeal
//
//  Created by Fernando Brito on 13/08/23.
//

import UIKit

class MealCollectionViewCell: UICollectionViewCell {
    static let identifier = K.CellIDs.MealCollectionView

    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        contentView.addSubview(mealImageView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        configureConstraints()
    }

    private func configureConstraints() {
        let mealImageViewConstraints = [
            mealImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mealImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mealImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mealImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width),
        ]

        NSLayoutConstraint.activate(mealImageViewConstraints)
    }

    public func configure(withURL url: String) {
        guard let url = URL(string: url) else { return }

        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }

            DispatchQueue.main.async {
                self.mealImageView.image = UIImage(data: data)
            }
        }
    }
}
