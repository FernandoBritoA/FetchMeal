//
//  Helpers.swift
//  FetchMeal
//
//  Created by Fernando Brito on 13/08/23.
//

import Foundation

struct Helpers {
    static let shared = Helpers()
    
    // If the label starts with the string "strIngredient" or "strMeasure", we extract the ingredint index
    // e.g.: Input  = "strIngredient10" --> Output = 9
    public func getIngredientIndex(from label: String) -> Int? {
        let baseLabelA = "strIngredient"
        let baseLabelB = "strMeasure"
        
        if label.contains(baseLabelA) || label.contains(baseLabelB) {
            let lastChar = label.suffix(1)
            let lastTwoChars = label.suffix(2)
            
            guard let index = Int(lastTwoChars) ?? Int(lastChar) else {
                return nil
            }
            
            // Labels ingredients goes from 1 to 20, we need to substract 1 to start the array with a 0 index
            return index - 1
        }
        
        return nil
    }
    
    // Converts the MealDetail model into a MealInstructions model with an array of the ingredients
    // e.g.:
    // Input  = {strMeal: "Apple Pie", strInstructions: "Cook pie", strIngredient1: "Apple",
    //           strMeasure1: "1", strIngredient2: "Flour", strMeasure1: "100g", ...}
    // Output = {title: "Apple Pie", instructions: "Cook pie", ingredients: ["Apple: 1", "Flour: 100g"]}
    public func formatMealDetail(from model: MealDetail) -> MealInstructions {
        var ingredients: [String] = []
        let mirror = Mirror(reflecting: model)
        let mappedMirror = mirror.children.map { ($0.label, $0.value) }
        
        for case let (label?, value) in mappedMirror {
            let index = getIngredientIndex(from: label)
            
            if let index = index, let value = value as? String, value != "", value != " " {
                if ingredients.indices.contains(index) {
                    let ingredient = ingredients[index]
                    
                    ingredients[index] = "\(ingredient): \(value)"
                } else {
                    ingredients.append(value)
                }
            }
        }
        
        return MealInstructions(title: model.strMeal, instructions: model.strInstructions, ingredients: ingredients)
    }
}
