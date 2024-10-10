//
//  Recipe.swift
//  Recipes
//
//  Created by Mason Peralta on 10/9/24.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id: String { uuid }  // Using uuid as the unique identifier
    var cuisine: String
    var name: String
    var photoUrlLarge: String
    var photoUrlSmall: String
    var sourceUrl: String
    var uuid: String
    var youtubeUrl: String
    
    // Coding keys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case uuid
        case youtubeUrl = "youtube_url"
    }
    
    // Custom initializer to provide default values when keys are missing
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        cuisine = try container.decodeIfPresent(String.self, forKey: .cuisine) ?? "Unknown Cuisine"
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Unknown Name"
        photoUrlLarge = try container.decodeIfPresent(String.self, forKey: .photoUrlLarge) ?? "https://example.com/default_large.jpg"
        photoUrlSmall = try container.decodeIfPresent(String.self, forKey: .photoUrlSmall) ?? "https://example.com/default_small.jpg"
        sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl) ?? "https://example.com/default_source"
        uuid = try container.decodeIfPresent(String.self, forKey: .uuid) ?? UUID().uuidString
        youtubeUrl = try container.decodeIfPresent(String.self, forKey: .youtubeUrl) ?? "https://example.com/default_video"
    }
    
    // Default initializer in case you need to create a recipe manually
    init(cuisine: String = "Unknown Cuisine",
         name: String = "Unknown Name",
         photoUrlLarge: String = "https://example.com/default_large.jpg",
         photoUrlSmall: String = "https://example.com/default_small.jpg",
         sourceUrl: String = "https://example.com/default_source",
         uuid: String = UUID().uuidString,
         youtubeUrl: String = "https://youtube.com/default_video") {
        self.cuisine = cuisine
        self.name = name
        self.photoUrlLarge = photoUrlLarge
        self.photoUrlSmall = photoUrlSmall
        self.sourceUrl = sourceUrl
        self.uuid = uuid
        self.youtubeUrl = youtubeUrl
    }
}


struct RecipeResponse: Codable {
    var recipes: [Recipe]
}
