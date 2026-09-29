//
//  NewsImageManager.swift
//  NewsFeedSwiftUI
//
//  Created by Laasya Priya vemuri on 9/28/26.
//

import Foundation
import SwiftUI

protocol ImageCacheProtocol: AnyObject {
    func fetchImage(for url: URL) async throws -> UIImage
}

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSURL, UIImage>()
    private init() { }

    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }

    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
}

class ImageManager: ImageCacheProtocol {
    static let shared = ImageManager()

    private let cache = ImageCache.shared

    private init() { }

    func fetchImage(for url: URL) async throws -> UIImage {
        if let cachedImage = cache.getImage(for: url) {
            print("Log:: Image fetched from cache")
            return cachedImage
        }

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw ErrorType.networkError
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ErrorType.badServerResponse(statusCode: 0)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw ErrorType.badServerResponse(statusCode:httpResponse.statusCode)
        }

        guard let image = UIImage(data: data) else {
            throw ErrorType.decodingFailed
        }

        print("Log:: Image fetched from server")

        cache.setImage(image, for: url)
        return image
    }

    func isImageCached(for url: URL) -> Bool {
        return cache.getImage(for: url) != nil
    }

    func getCachedImage(for url: URL) -> UIImage? {
        return cache.getImage(for: url)
    }
}
