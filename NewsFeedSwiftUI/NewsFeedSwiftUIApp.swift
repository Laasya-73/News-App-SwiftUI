//
//  NewsFeedSwiftUIApp.swift
//  NewsFeedSwiftUI
//
//  Created by Laasya Priya vemuri on 9/28/26.
//

import SwiftUI

@main
struct NewsFeedSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            NewsScreen(viewModel: NewsViewModel(objNetwork: NewsNetworkManager.shared))
        }
    }
}
