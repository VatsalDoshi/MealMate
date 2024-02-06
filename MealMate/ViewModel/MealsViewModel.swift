//
//  MealsViewModel.swift
//  Fetch-codingChallenge
//
//  Created by Vatsal Doshi on 1/17/24.
//

import Foundation
import Combine

class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selectedMealDetail: MealDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let networkManager = NetworkManager()

    func fetchDesserts() {
        networkManager.fetchDesserts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching desserts: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] fetchedMeals in
                self?.meals = fetchedMeals.sorted { $0.strMeal < $1.strMeal }
            })
            .store(in: &cancellables)
    }



    func fetchMealDetails(id: String) {
        networkManager.fetchMealDetails(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] mealDetail in
                      self?.selectedMealDetail = mealDetail
                  })
            .store(in: &cancellables)
    }

}
