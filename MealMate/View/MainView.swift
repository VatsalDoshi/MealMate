//
//  MainView.swift
//  Fetch-codingChallenge
//
//  Created by Vatsal Doshi on 1/18/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.categories) { category in
                Text(category.strCategory)
            }
            .navigationBarTitle("Categories")
            .onAppear {
                viewModel.fetchCategories()
            }
        }
    }
}


#Preview {
    MainView()
}
