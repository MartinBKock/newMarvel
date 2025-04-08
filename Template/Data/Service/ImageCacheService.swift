//
//  ImageCacheService.swift
//  Template
//
//  Created by Martin Kock on 08/04/2025.
//

import Foundation
import SwiftUI

public class ImageCacheService {
    
    // MARK: - Private init
    init() {}
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    private let fileManager = FileManager.default
    private let memoryCache = NSCache<NSString, UIImage>()
    
    private lazy var cacheDirectory: URL = {
        let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[0]
    }()
    
    // MARK: - public functions
    func loadImage(withURL url: URL, completion: @escaping (UIImage?) -> Void) {
        let fileName = url.absoluteString.replacingOccurrences(of: "/", with: "_")
        let fileURL = cacheDirectory.appendingPathComponent(fileName)

        if let cachedImage = memoryCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            return
        }

        if fileManager.fileExists(atPath: fileURL.path) {
            if let data = fileManager.contents(atPath: fileURL.path),
               let image = UIImage(data: data) {
                memoryCache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image)
                return
            }
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            do {
                try data.write(to: fileURL)
                self.memoryCache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image)
            } catch {
                print("Error saving image: \(error)")
                completion(nil)
            }
        }.resume()
    }

}
