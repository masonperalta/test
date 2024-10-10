//
//  RecipeServiceTests.swift
//  RecipesTests
//
//  Created by Mason Peralta on 10/9/24.
//

import XCTest
@testable import Recipes

final class RecipeServiceTests: XCTestCase {

    var settings: GlobalSettings!

    override func setUp() async throws {
        try await super.setUp()
        settings = await GlobalSettings()
    }

    override func tearDown() async throws {
        settings = nil
        try await super.tearDown()
    }

    @MainActor
    func testFetchRemoteJsonAndDecode() async throws {
        let jsonUrlString = "https://raw.githubusercontent.com/masonperalta/test/refs/heads/main/recipes.json"
        guard let url = URL(string: jsonUrlString) else {
            XCTFail("Invalid URL")
            return
        }
        
        // Fetch JSON data from the remote URL
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Check if the response status is 200 OK
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                XCTFail("Failed to fetch JSON: Invalid status code")
                return
            }

            // Decode the JSON into RecipeResponse
            let decoder = JSONDecoder()
            let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
            
            // Ensure there are recipes in the response
            XCTAssertGreaterThan(recipeResponse.recipes.count, 0, "No recipes found in the fetched JSON")
            
            // Verify a recipe's properties (assuming first one for testing)
            let firstRecipe = recipeResponse.recipes.first
            XCTAssertNotNil(firstRecipe, "First recipe is nil")
            XCTAssertFalse(firstRecipe?.name.isEmpty ?? true, "Recipe name is empty")
            XCTAssertFalse(firstRecipe?.uuid.isEmpty ?? true, "Recipe uuid is empty")
            XCTAssertFalse(firstRecipe?.photoUrlLarge.isEmpty ?? true, "Recipe photoUrlLarge is empty")
            
            // Print recipes for debugging if necessary
            print(recipeResponse.recipes)
            
        } catch {
            XCTFail("Failed to fetch or decode JSON: \(error)")
        }
    }
}
