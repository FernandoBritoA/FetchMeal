//
//  MealDetailViewController.swift
//  FetchMeal
//
//  Created by Fernando Brito on 13/08/23.
//

import UIKit

class MealDetailViewController: UIViewController {
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: K.Colors.backgroundBeige)
        view.addSubview(mealImageView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        configureConstraints()
    }

    private func configureConstraints() {
        let mealImageViewConstraints = [
            mealImageView.topAnchor.constraint(equalTo: view.topAnchor),
            mealImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mealImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mealImageView.heightAnchor.constraint(equalToConstant: view.frame.width),
        ]

        NSLayoutConstraint.activate(mealImageViewConstraints)
    }

    public func configure(with model: MealDetail) {
        guard let url = URL(string: model.strMealThumb) else { return }

        Task {
            await mealImageView.load(with: url)
        }
    }
}
