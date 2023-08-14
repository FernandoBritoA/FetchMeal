//
//  MealDetailViewController.swift
//  FetchMeal
//
//  Created by Fernando Brito on 13/08/23.
//

import UIKit

class MealDetailViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()

    private let scrollViewContainer: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = K.Dimensions.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let mealInstructionsView = MealInstructionsView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: K.Colors.backgroundBeige)

        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)

        scrollViewContainer.addArrangedSubview(mealImageView)
        scrollViewContainer.addArrangedSubview(mealInstructionsView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        configureConstraints()
        mealInstructionsView.frame = scrollViewContainer.bounds
    }

    private func configureConstraints() {
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]

        let scrollViewContainerConstraints = [
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ]

        let mealImageViewConstraints = [
            mealImageView.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor),
            mealImageView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            mealImageView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            mealImageView.heightAnchor.constraint(equalToConstant: view.frame.width),
        ]

        NSLayoutConstraint.activate(
            scrollViewConstraints + scrollViewContainerConstraints + mealImageViewConstraints
        )
    }

    public func configure(with model: MealDetail) {
        guard let url = URL(string: model.strMealThumb) else { return }

        let instructions = MealInstructions(title: model.strMeal, instructions: model.strInstructions, ingredients: [""])
        mealInstructionsView.configure(with: instructions)

        Task {
            await mealImageView.load(with: url)
        }
    }
}
