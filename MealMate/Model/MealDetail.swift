//
//  MealDetail.swift
//  Fetch-codingChallenge
//
//  Created by Vatsal Doshi on 1/17/24.
//

import Foundation

struct MealDetail: Decodable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    var ingredients: [String: String] = [:]

    var id: String { idMeal }

    private enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)

        let additionalContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        for index in 1...20 {
            let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(index)")!
            let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(index)")!

            if let ingredient = try additionalContainer.decodeIfPresent(String.self, forKey: ingredientKey),
               !ingredient.isEmptyOrWhitespace(),
               let measure = try additionalContainer.decodeIfPresent(String.self, forKey: measureKey),
               !measure.isEmptyOrWhitespace() {
                ingredients[ingredient] = measure
            }
        }
    }

    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    init(idMeal: String, strMeal: String, strInstructions: String, ingredients: [String: String]) {
            self.idMeal = idMeal
            self.strMeal = strMeal
            self.strInstructions = strInstructions
            self.ingredients = ingredients
        }
}

extension String {
    func isEmptyOrWhitespace() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}





