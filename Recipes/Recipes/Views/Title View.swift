//
//  Title View.swift
//  Recipes
//
//  Created by Mason Peralta on 10/9/24.
//

import SwiftUI

struct Title_View: View {
    
    let image: String
    let text: String
    let font: Font
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: image)
                Text(text)
            }.font(font)
                .foregroundStyle(.primary)
            Divider()
        }
    }
}

#Preview {
    Title_View(image: "", text: "", font: .title)
}
