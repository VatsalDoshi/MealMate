//
//  Category.swift
//  Fetch-codingChallenge
//
//  Created by Vatsal Doshi on 1/18/24.
//

import Foundation

struct Category: Identifiable, Decodable {
    let id = UUID()
    let strCategory: String
}

struct Categories: Decodable {
    let meals: [Category]
}
