//
//  ViewController.swift
//  FetchMeal
//
//  Created by Fernando Brito on 11/08/23.
//

import UIKit

class MealsListViewController: UIViewController {
    private var meals: [MealPreview] = []

    private let mealCollectionView: UICollectionView = {
        let spacing = 20.0
        let layout = UICollectionViewFlowLayout()

        layout.minimumLineSpacing = spacing / 2
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: (screenWidth - spacing * 3) / 2, height: 250)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: spacing * 2, left: spacing, bottom: 0, right: spacing)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        return collectionView
    }()

    private func addCollectionView() {
        view.addSubview(mealCollectionView)

        mealCollectionView.delegate = self
        mealCollectionView.dataSource = self
    }

    private func fetchMeals() async {
        do {
            meals = try await ApiCaller.shared.getMealsByCategory(category: .dessert)

            mealCollectionView.reloadData()

        } catch {
            print(error)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: K.Colors.backgroundBeige)

        addCollectionView()

        Task {
            await fetchMeals()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        mealCollectionView.frame = view.bounds
    }
}

extension MealsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meals.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

        return cell
    }
}
