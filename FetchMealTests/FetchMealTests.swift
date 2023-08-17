//
//  FetchMealTests.swift
//  FetchMealTests
//
//  Created by Fernando Brito on 14/08/23.
//

@testable import FetchMeal
import XCTest

final class FetchMealTests: XCTestCase {
    func testGetIngredientIndex() {
        let ingredientLabel = "strIngredient4"
        let measureLabel = "strMeasure10"
        let invalidLabel = "idMeal"

        let oneDigitIndex = Helpers.shared.getIngredientIndex(from: ingredientLabel)
        let twoDigitIndex = Helpers.shared.getIngredientIndex(from: measureLabel)
        let invalidIndex = Helpers.shared.getIngredientIndex(from: invalidLabel)

        XCTAssertEqual(oneDigitIndex, 3)
        XCTAssertEqual(twoDigitIndex, 9)
        XCTAssertNil(invalidIndex)
    }

    func testSuccessfulFormatMealDetail() {
        let mealDetail = MealDetail(idMeal: "1234", strMeal: "Apple Pie", strInstructions: "Cook Pie", strMealThumb: "", strIngredient1: "Apple", strMeasure1: "1", strIngredient2: "Flour", strMeasure2: "100g", strIngredient3: "", strMeasure3: "", strIngredient4: nil, strMeasure4: nil, strIngredient5: nil, strMeasure5: nil, strIngredient6: nil, strMeasure6: nil, strIngredient7: nil, strMeasure7: nil, strIngredient8: nil, strMeasure8: nil, strIngredient9: nil, strMeasure9: nil, strIngredient10: nil, strMeasure10: nil, strIngredient11: nil, strMeasure11: nil, strIngredient12: nil, strMeasure12: nil, strIngredient13: nil, strMeasure13: nil, strIngredient14: nil, strMeasure14: nil, strIngredient15: nil, strMeasure15: nil, strIngredient16: nil, strMeasure16: nil, strIngredient17: nil, strMeasure17: nil, strIngredient18: nil, strMeasure18: nil, strIngredient19: nil, strMeasure19: nil, strIngredient20: nil, strMeasure20: nil)

        let output = Helpers.shared.formatMealDetail(from: mealDetail)
        let expectedOutput = MealInstructions(
            title: "Apple Pie",
            instructions: "Cook Pie",
            ingredients: ["Apple: 1", "Flour: 100g"])

        XCTAssertEqual(output.title, expectedOutput.title)
        XCTAssertEqual(output.instructions, expectedOutput.instructions)
        XCTAssertEqual(output.ingredients, expectedOutput.ingredients)
    }
}
