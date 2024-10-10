//
//  Web Page.swift
//  Recipes
//
//  Created by Mason Peralta on 10/9/24.
//

import SwiftUI

struct Web_Page: View {
    
    let url: String
    let image: String
    let color: Color
    @State private var size: CGFloat = 18
    @EnvironmentObject var settings: GlobalSettings
    
    var body: some View {
        if !url.contains("example.com") {
            Image(systemName: image)
                .resizable()
                .frame(width: size, height: size)
                .foregroundColor(color)
                .onTapGesture {
                    openSafari(urlString: url)
                }.onChange(of: settings.isTapped) {
                    if settings.isTapped { size = 36 }
                    else { size = 18 }
                }
        }
    }
    
    func openSafari(urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        } else {
            print("Invalid URL")
        }
    }
}

#Preview {
    Web_Page(url: "", image: "", color: .primary)
        .environmentObject(GlobalSettings())
}
