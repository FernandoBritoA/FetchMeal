//
//  MealCollectionViewController.swift
//  FetchMeal
//
//  Created by Fernando Brito on 11/08/23.
//

import UIKit

class MealCollectionViewController: UIViewController {
    private var meals: [MealPreview] = []

    private let mealCollectionView: UICollectionView = {
        let spacing = K.Dimensions.spacing
        let layout = UICollectionViewFlowLayout()

        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: (screenWidth - spacing * 3) / 2, height: 250)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        collectionView.register(MealCollectionViewCell.self, forCellWithReuseIdentifier: MealCollectionViewCell.identifier)

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = K.MealCollectionTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
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
            showToast(message: error.localizedDescription, type: .error)
        }
    }
}

extension MealCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meals.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCollectionViewCell.identifier, for: indexPath) as? MealCollectionViewCell else {
            return UICollectionViewCell()
        }

        let mealData = meals[indexPath.row]

        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
        cell.configure(with: mealData)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let mealData = meals[indexPath.row]

        let viewController = MealDetailViewController()

        Task {
            do {
                let mealDetail = try await ApiCaller.shared.getMealDetail(withId: mealData.idMeal)
                viewController.configure(with: mealDetail)
                navigationController?.present(viewController, animated: true)
            } catch {
                showToast(message: error.localizedDescription, type: .error)
            }
        }
    }
}
