//
//  MealPreview.swift
//  FetchMeal
//
//  Created by Fernando Brito on 12/08/23.
//

import Foundation

struct MealPreview: Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}

struct FetchMealPreviewsResponse: Decodable {
    var meals: [MealPreview]
}
