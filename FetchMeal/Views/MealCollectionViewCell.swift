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

    let mealLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        contentView.addSubview(mealImageView)
        contentView.addSubview(mealLabel)
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

        let mealLabelConstraints = [
            mealLabel.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: 10),
            mealLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mealLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mealLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ]

        NSLayoutConstraint.activate(mealImageViewConstraints + mealLabelConstraints)
    }

    public func configure(with model: MealPreview) {
        guard let url = URL(string: model.strMealThumb) else { return }

        mealLabel.text = model.strMeal
        Task {
            await mealImageView.load(with: url)
        }
    }
}
