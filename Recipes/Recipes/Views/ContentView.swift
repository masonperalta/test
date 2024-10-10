//
//  ContentView.swift
//  Recipes
//
//  Created by Mason Peralta on 10/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var settings: GlobalSettings
    
    var body: some View {
        ZStack {
            settings.gradientLinear.opacity(0.9).ignoresSafeArea()
            VStack (alignment: .center) {
                Title_View(image: "fork.knife", text: "Recipes", font: .largeTitle)
                ScrollView  {
                    if !settings.isFetching {
                        if settings.recipes.count > 0 {
                            ForEach(settings.recipes) { recipe in
                                if settings.cusineSelected == recipe.cuisine || settings.cusineSelected == "All" && !recipe.name.contains("Unknown") && !recipe.cuisine.contains("Unknown") {
                                    HStack (alignment: .center) {
                                        VStack (alignment: .leading) {
                                            Text(recipe.name)
                                                .foregroundStyle(.primary)
                                                .font(.headline)
                                                .padding(.top)
                                            Text(recipe.cuisine)
                                                .font(.body)
                                                .foregroundStyle(.secondary)
                                            HStack {
                                                Web_Page(url: recipe.sourceUrl, image: "safari", color: .primary)
                                                    .padding(.trailing, 5)
                                                Web_Page(url: recipe.youtubeUrl, image: "play.rectangle", color: .pink)
                                            }.padding(.bottom)
                                            
                                        }.padding(.leading)
                                        Spacer()
                                        if !settings.isTapped {
                                            Photo_View(imageUrl: recipe.photoUrlSmall, fullsize: false, cornerRadiusDiv: 2)
                                                .padding(.all)
                                        }
                                        else {
                                            Photo_View(imageUrl: recipe.photoUrlLarge, fullsize: true, cornerRadiusDiv: 6)
                                                .padding(.all)
                                        }
                                    }
                                    .background(
                                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                                            .stroke(.primary, style: StrokeStyle(lineWidth: 0.5))
                                    ).onTapGesture {
                                        settings.isTapped.toggle()
                                    }
                                }
                            }
                        }
                        else {
                            HStack {
                                Text("No recipes found")
                                Image(systemName: "photo.artframe")
                            }.font(.title).foregroundStyle(.secondary)
                        }
                    }
                    
                    else {
                        ProgressView()
                    }
                }.refreshable {
                    settings.cusineSelected = "All"
                    loadJson()
                }.clipShape(RoundedRectangle(cornerRadius: 6))
                Divider()
                Picker_View().padding(.top)
            }
            .padding()
            .onAppear {
                loadJson()
            }
        }
    }
    private func loadJson() {
        Task {
            print("refreshing JSON.....")
            settings.isFetching = true
            _ = await getJson(settings: settings, endpoint: settings.recipeUrl)
            settings.isFetching = false
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalSettings())
}
