//
//  FetchMealTests.swift
//  FetchMealTests
//
//  Created by Fernando Brito on 14/08/23.
//

@testable import FetchMeal
import XCTest

final class FetchMealTests: XCTestCase {
    func testDecodingMealDetail() {
        let stringJSON = """
        {
           "idMeal": "123",
           "strMeal": "Apple Pie",
           "strMealThumb": "www.image.jpg",
           "strInstructions": "Cook Pie",
           "strIngredient1": "Apple",
           "strMeasure1": "2",
           "strIngredient2": "Flour",
           "strMeasure2": "20g",
           "strIngredient3": "Bread",
           "strMeasure3": "2 slices",
           "strIngredient4": "Sugar",
           "strMeasure4": "300g",
           "strIngredient5": "",
           "strMeasure5": "",
           "strIngredient6": " ",
           "strMeasure6": " ",
           "strIngredient7": "Butter",
           "strMeasure7": "2oz",
           "strIngredient8": null,
           "strMeasure8": null,
        }
        """

        let decoder = JSONDecoder()
        let dataJSON = stringJSON.data(using: .utf8)

        let output = try! decoder.decode(MealDetail.self, from: dataJSON!)
        let expectedOutput = MealDetail(
            id: "123",
            name: "Apple Pie",
            imageURL: "www.image.jpg",
            instructions: "Cook Pie",
            ingredients: ["Apple: 2", "Flour: 20g", "Bread: 2 slices", "Sugar: 300g", "Butter: 2oz"])

        XCTAssertEqual(output.id, expectedOutput.id)
        XCTAssertEqual(output.name, expectedOutput.name)
        XCTAssertEqual(output.imageURL, expectedOutput.imageURL)
        XCTAssertEqual(output.instructions, expectedOutput.instructions)
        XCTAssertEqual(output.ingredients, expectedOutput.ingredients)
    }
}
