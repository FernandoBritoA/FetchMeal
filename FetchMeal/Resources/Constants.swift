//
//  Constants.swift
//  FetchMeal
//
//  Created by Fernando Brito on 12/08/23.
//

import Foundation
import UIKit

struct K {
    static let MealCollectionTitle = "Desserts"

    enum Colors {
        static let backgroundBeige = "backgroundBeige"
    }

    enum CellIDs {
        static let MealCollectionView = "MealCollectionView"
    }

    enum Dimensions {
        static let spacing = 20.0
    }
}

// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}
