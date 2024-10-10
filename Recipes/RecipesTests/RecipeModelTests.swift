//
//  RecipeModelTests.swift
//  RecipesTests
//
//  Created by Mason Peralta on 10/9/24.
//

import XCTest
@testable import Recipes  // Replace with your app's module name

class RecipeModelTests: XCTestCase {

    func testRecipeDecoding() throws {
        let json = """
        {
            "name": "Banana Pancakes",
            "cuisine": "American",
            "photo_url_small": "https://example.com/banana-pancakes.jpg",
            "uuid": "12345"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let recipe = try decoder.decode(Recipe.self, from: json)

        XCTAssertEqual(recipe.name, "Banana Pancakes")
        XCTAssertEqual(recipe.cuisine, "American")
        XCTAssertEqual(recipe.photoUrlSmall, "https://example.com/banana-pancakes.jpg")
        XCTAssertEqual(recipe.uuid, "12345")
    }
}

