//
//  MealDetailView.swift
//  Fetch-codingChallenge
//
//  Created by Vatsal Doshi on 1/17/24.
//

import SwiftUI
import Combine

struct MealDetailView: View {
    var mealID: String
    @State private var mealDetail: MealDetail?
    @State private var isLoading = true
    @State private var cancellables = Set<AnyCancellable>()

    var body: some View {
            ScrollView {
                if let mealDetail = mealDetail {
                    VStack(alignment: .leading) {
                        Text(mealDetail.strMeal)
                            .font(.largeTitle)
                            .padding()

                        Text("Instructions")
                            .font(.headline)
                            .padding(.top)

                        Text(mealDetail.strInstructions)
                            .padding()

                        Text("Ingredients")
                            .font(.headline)
                            .padding(.top)

                        ForEach(mealDetail.ingredients.sorted(by: { $0.key < $1.key }), id: \.key) { ingredient, measure in
                            HStack {
                                Text("• \(ingredient): \(measure)")
                            }
                            .padding(.top, 2)
                            .padding(.bottom, 1)
                        }
                    }
                } else {
                    Text("Loading...")
                }
            }
            .padding()
            .onAppear(perform: loadMealDetail)
        }

    private func loadMealDetail() {
        NetworkManager().fetchMealDetails(id: mealID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    isLoading = false
                case .finished:
                    isLoading = false
                }
            }, receiveValue: { fetchedMealDetail in
                self.mealDetail = fetchedMealDetail
            })
            .store(in: &cancellables)
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(mealID: "53049")
    }
}



