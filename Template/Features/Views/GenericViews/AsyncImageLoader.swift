//
//  AsyncImageLoader.swift
//  Dev
//
//  Created by Martin Kock on 30/03/2024.
//

import SwiftUI

struct AsyncImageView: View {
    @State private var loadedImage: UIImage?
    private var imageLoader = Injector[\.imageCache]
    let urlString: String
    let placeholder: Image
    
    init(urlString: String, placeholder: Image = Image(systemName: "photo")) {
        self.urlString = urlString
        self.placeholder = placeholder
    }
    
    var body: some View {
        if let image = loadedImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .onDisappear {
                    loadedImage = nil
                }
        } else {
            placeholder
                .resizable()
                .scaledToFit()
                .onAppear {
                    loadedImage = nil
                    loadImage()
                }
        }
    }
    
    private func loadImage() {
        guard let url = URL(string: urlString.setHTTPSinsteadOfHTTP()) else {
            return
        }
        imageLoader.loadImage(withURL: url) { image in
            if let image = image {
                DispatchQueue.main.async {
                    loadedImage = image
                }
            }
        }
    }
    
}
