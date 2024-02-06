//
//  NetworkManager.swift
//  Fetch-codingChallenge
//
//  Created by Vatsal Doshi on 1/17/24.
//

import Foundation
import Combine

class NetworkManager {
    func fetchDesserts() -> AnyPublisher<[Meal], Error> {
            let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
            return URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: MealsResponse.self, decoder: JSONDecoder())
                .map(\.meals)
                .eraseToAnyPublisher()
        }

    func fetchMealDetails(id: String) -> AnyPublisher<MealDetail, Error> {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MealDetailResponse.self, decoder: JSONDecoder())
            .map(\.meals.first)
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    func fetchCategories() -> AnyPublisher<Categories, Error> {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?c=list")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Categories.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}


    

struct MealsResponse: Decodable {
    let meals: [Meal]
}

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}





