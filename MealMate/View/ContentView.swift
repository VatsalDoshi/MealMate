//
//  ContentView.swift
//  Fetch-codingChallenge
//
//  Created by Vatsal Doshi on 1/17/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MealsViewModel

    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                    Text(meal.strMeal)
                }
            }
            .navigationBarTitle("Desserts")
            .onAppear {
                viewModel.fetchDesserts()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: MealsViewModel())
    }
}



