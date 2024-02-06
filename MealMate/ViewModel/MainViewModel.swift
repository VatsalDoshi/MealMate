//
//  MainViewModel.swift
//  Fetch-codingChallenge
//
//  Created by Vatsal Doshi on 1/18/24.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var categories: [Category] = []
    private var cancellables = Set<AnyCancellable>()

    func fetchCategories() {
        NetworkManager().fetchCategories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] fetchedCategories in
                      self?.categories = fetchedCategories.meals
                  })
            .store(in: &cancellables)
    }
}

