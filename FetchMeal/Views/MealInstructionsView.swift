//
//  MealInstructionsView.swift
//  FetchMeal
//
//  Created by Fernando Brito on 13/08/23.
//

import UIKit

class MealInstructionsView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()

        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let ingredientStackView: BulletPointsStackView = {
        let stackView = BulletPointsStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let instructionsLabel: UILabel = {
        let label = UILabel()

        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        addSubview(ingredientStackView)
        addSubview(instructionsLabel)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        configureConstraints()
    }

    private func configureConstraints() {
        let spacing = K.Dimensions.spacing

        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
        ]

        let ingredientStackViewConstraints = [
            ingredientStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            ingredientStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            ingredientStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
        ]

        let instructionsLabelConstraints = [
            instructionsLabel.topAnchor.constraint(equalTo: ingredientStackView.bottomAnchor, constant: spacing),
            instructionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            instructionsLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]

        NSLayoutConstraint.activate(titleLabelConstraints + ingredientStackViewConstraints + instructionsLabelConstraints)
    }

    public func configure(with model: MealInstructions) {
        titleLabel.text = model.title
        instructionsLabel.text = model.instructions
        ingredientStackView.configure(with: model.ingredients)
    }
}
