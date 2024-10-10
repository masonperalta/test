//
//  Network.swift
//  Recipes
//
//  Created by Mason Peralta on 10/9/24.
//

import Foundation


@MainActor func getJson(settings: GlobalSettings, endpoint: String) async -> String {
       
    let errorJsonString = "error"
    
    // create and send the request
    let components = URLComponents(string: endpoint)
    let url = components?.url ?? URLComponents(string: "https://error.error.com")?.url
    var request = URLRequest(url: url!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    guard let (data, response) = try? await URLSession.shared.data(for: request)
    else {
        print(errorJsonString)
        settings.responseStatus = .not_found
        // TODO: parse the settings.errorJson to populate UI
        //do {
            //let decoder = JSONDecoder()
            //let recipe = try decoder.decode(Recipe.self, from: settings.errorJson)

        //   } catch {
        //       print("error")
        //   }
        
        return errorJsonString
    }
    
    // Check status code
    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
    if statusCode != 200 {
        settings.responseStatus = .error_general
        print("Error: \(errorJsonString): \(statusCode)")
        return "Error: \(statusCode): \(statusCode)"
    }
    
    
    do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(RecipeResponse.self, from: data)
        settings.recipes = response.recipes
        //print(settings.recipes)
        
        var tempArray: [String] = []
        
        for recipe in settings.recipes {
            tempArray.append(recipe.cuisine)
        }
        tempArray.append("All")
        settings.cuisines = Array(Set(tempArray)).sorted()

    } catch {
        print("Error parsing JSON: \(error)")
    }
    
    return "Success"
    
}
