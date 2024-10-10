//
//  Picker View.swift
//  Recipes
//
//  Created by Mason Peralta on 10/10/24.
//

import SwiftUI

struct Picker_View: View {
    
    @EnvironmentObject var settings: GlobalSettings
    
    var body: some View {
        HStack {
            Text("Filter cuisine: ")
            Picker(selection: $settings.cusineSelected, label: Text("")) {
                ForEach(settings.cuisines, id: \.self) { cuisine in
                    Text(cuisine).tag(cuisine)
                }
            }.background(
                RoundedRectangle(cornerRadius: 11, style: .continuous)
                    .stroke(.secondary, style: StrokeStyle(lineWidth: 0.5))
            )
            .padding(.leading, -7)
            .onAppear {
                // Ensure "All" is part of the settings.cuisines array
                if !settings.cuisines.contains("All") {
                    settings.cuisines.insert("All", at: 0) // Add "All" as the first option
                }
            }
            .onChange(of: settings.cusineSelected) {
                settings.isFetching = true
                settings.isFetching = false
            }
        }.font(.callout)
            .foregroundStyle(.secondary)
    }
}

#Preview {
    Picker_View()
        .environmentObject(GlobalSettings())
}
