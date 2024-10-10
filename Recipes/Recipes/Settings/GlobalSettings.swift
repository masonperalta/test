//
//  GlobalSettings.swift
//  Recipes
//
//  Created by Mason Peralta on 10/9/24.
//

import Foundation
import SwiftUI


@MainActor class GlobalSettings: ObservableObject {
    
    @Published var gradientLinear = LinearGradient(gradient: Gradient(colors: [Color("bgColor1"), Color("bgColor1"), Color("bgColor1"), Color("bgColor1")]), startPoint: .top, endPoint: .bottom)
    
    @Published var recipeUrl: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    // https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json
    // https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json
    // https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json
    @Published var responseStatus: ResponseStatus = .success
    @Published var isTapped: Bool = false
    // Add error responses for UI when a network error is encountered
    @Published var errorJson: String = """

"""
    
    // JSON
    @Published var recipes: [Recipe] = []
    @Published var cuisines: [String] = []
    @Published var cusineSelected: String = "All"
    @Published var isFetching: Bool = true
}




enum ResponseStatus: String {
    
    case success = "Success"
    case not_found = "Error: page not found"
    case error_general = "Error"
    
}


