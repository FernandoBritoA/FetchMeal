//
//  MealDetail.swift
//  FetchMeal
//
//  Created by Fernando Brito on 12/08/23.
//

import Foundation

struct FetchMealDetailResponse: Decodable {
    let meals: [MealDetail]
}

// The actual keys from JSON
enum CodingKeys: String, CodingKey {
    case idMeal
    case strMeal
    case strInstructions
    case strMealThumb

    // Sequential values
    case strIngredient
    case strMeasure
}

struct MealKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        stringValue = String(intValue)
        self.intValue = intValue
    }
}

func isValidString(_ text: String?) -> Bool {
    return text != nil && text != "" && text != " "
}

struct MealDetail: Decodable {
    // Our keys, could be customized
    var id: String = ""
    var name: String = ""
    var imageURL: String = ""
    var instructions: String = ""
    var ingredients: [String] = []

    private func getMealKey(_ key: CodingKeys, index: Int? = nil) -> MealKey {
        var stringValue: String = key.rawValue

        if let index = index {
            stringValue += String(index)
        }

        return MealKey(stringValue: stringValue)!
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MealKey.self)

        id = try container.decode(String.self, forKey: getMealKey(.idMeal))
        name = try container.decode(String.self, forKey: getMealKey(.strMeal))
        imageURL = try container.decode(String.self, forKey: getMealKey(.strMealThumb))
        instructions = try container.decode(String.self, forKey: getMealKey(.strInstructions))

        var index = 1
        var ingredientsLimitReached = false

        while !ingredientsLimitReached {
            do {
                guard
                    let ingredient = try container.decodeIfPresent(String.self, forKey: getMealKey(.strIngredient, index: index)),
                    let measure = try container.decodeIfPresent(String.self, forKey: getMealKey(.strMeasure, index: index))
                else {
                    ingredientsLimitReached = true
                    break
                }

                if isValidString(ingredient), isValidString(measure) {
                    ingredients.append("\(ingredient): \(measure)")
                }

                index += 1
            } catch {
                print(error)
            }
        }
    }
}
