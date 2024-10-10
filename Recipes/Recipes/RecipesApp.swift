//
//  RecipesApp.swift
//  Recipes
//
//  Created by Mason Peralta on 10/9/24.
//

import SwiftUI

@main
struct RecipesApp: App {
    
    @StateObject private var globalSettings = GlobalSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GlobalSettings())
        }
    }
}
