//
//  ErrorType.swift
//  NewsFeedSwiftUI
//
//  Created by Laasya Priya vemuri on 9/28/26.
//

import Foundation

enum ErrorType: Error {
    case networkError
    case invalidURL
    case badServerResponse(statusCode: Int)
    case decodingFailed
}
