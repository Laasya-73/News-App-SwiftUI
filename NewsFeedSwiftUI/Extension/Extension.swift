//
//  Extension.swift
//  NewsFeedSwiftUI
//
//  Created by Laasya Priya vemuri on 9/28/26.
//

import SwiftUI

extension UIImageView {
    func downloadImage(from imageURLString: String?) {
        image = UIImage(systemName: NewsConstants.defaultImagePlaceholder.rawValue)

        guard let imageURLString = imageURLString, let imageURL = URL(string: imageURLString) else {
            return
        }

        Task { [weak self] in
            do {
                let fetchedImage = try await ImageManager.shared.fetchImage(for: imageURL)
                await MainActor.run {
                    self?.image = fetchedImage
                }

            } catch {
                print("Log:: Image error \(error)")
                await MainActor.run {
                    self?.image = UIImage(systemName: NewsConstants.defaultImagePlaceholder.rawValue)
                }
            }
        }
    }
}


extension String {
    func formatDate() -> String {
        let inputFormatter = ISO8601DateFormatter()
        guard let date = inputFormatter.date(from: self) else {
            return self
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM dd, yyyy"
        return outputFormatter.string(from: date)
    }
}
