//
//  Photo View.swift
//  Recipes
//
//  Created by Mason Peralta on 10/9/24.
//

import SwiftUI

struct Photo_View: View {
    
    let imageUrl: String
    let fullsize: Bool
    let cornerRadiusDiv: CGFloat
    
    @State private var imageSize: CGFloat = 75
    @State private var cachedImage: UIImage?
    
    var body: some View {
        ZStack {
            if let image = cachedImage {
                // Display the cached or downloaded image
                Image(uiImage: image)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .cornerRadius(imageSize / cornerRadiusDiv )
                    .shadow(radius: 7)
            } else {
                // Placeholder while loading
                Image(systemName: "fork.knife.circle.fill")
                    .resizable()
                    .font(.system(size: imageSize))
                    .foregroundColor(.primary)
                    .frame(width: imageSize, height: imageSize)
                    //.padding(.)
            }
        }
        .onAppear {
            // Adjust image size based on fullsize flag
            imageSize = fullsize ? 150 : 75
            
            // Load image from cache or download
            loadCachedImage()
        }
    }
    
    // Load image from cache or download if not available
    private func loadCachedImage() {
        guard let url = URL(string: imageUrl) else {
            print("Invalid URL")
            return
        }
        
        let cacheKey = cacheKeyForURL(url) // Create cache key based on full URL
        
        if let cachedImage = loadImageFromCache(forKey: cacheKey) {
            print("loading cached image.....")
            self.cachedImage = cachedImage
        } else {
            print("downloading the image.....")
            downloadImage(from: url, cacheKey: cacheKey)
        }
    }
    
    // Check for cached image in the local storage
    private func loadImageFromCache(forKey key: String) -> UIImage? {
        let path = getDocumentsDirectory().appendingPathComponent(key)
        if let data = try? Data(contentsOf: path) {
            return UIImage(data: data)
        }
        return nil
    }
    
    // Download image and cache it locally
    private func downloadImage(from url: URL, cacheKey: String) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let uiImage = UIImage(data: data) else {
                print("Failed to download image from URL:", url)
                return
            }

            // Save image to cache
            let path = getDocumentsDirectory().appendingPathComponent(cacheKey)
            try? data.write(to: path)

            // Update UI with the new image on the main thread
            DispatchQueue.main.async {
                self.cachedImage = uiImage
            }
        }.resume()
    }
    
    // Get the path to the Documents directory for caching
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    // Generate a unique cache key based on the full image URL
    private func cacheKeyForURL(_ url: URL) -> String {
        return url.absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString
    }
}




#Preview {
    Photo_View(imageUrl: "", fullsize: true, cornerRadiusDiv: 2)
}
