//
//  MealInstructionsView.swift
//  FetchMeal
//
//  Created by Fernando Brito on 13/08/23.
//

import UIKit

class MealInstructionsView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let instructionsLabel: UILabel = {
        let label = UILabel()

        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        addSubview(instructionsLabel)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        configureConstraints()

    }
    
    private func configureConstraints(){
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        let instructionsLabelConstraints = [
            instructionsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            instructionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            instructionsLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]

        NSLayoutConstraint.activate(titleLabelConstraints + instructionsLabelConstraints)
    }

    public func configure(with model: MealInstructions) {
        titleLabel.text = model.title
        instructionsLabel.text = model.instructions
    }
}
