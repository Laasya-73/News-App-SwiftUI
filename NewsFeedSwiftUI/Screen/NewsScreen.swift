//
//  NewsScreen.swift
//  NewsFeedSwiftUI
//
//  Created by Laasya Priya vemuri on 9/28/26.
//

import SwiftUI

struct NewsScreen: View {
    @State var viewModel: NewsViewModel
    
    var body: some View {
        NewsListView()
            .task {
                await viewModel.fetchNewsFromNetwork()
            }
            .environment(viewModel)
    }
}

struct NewsListView: View {
    //@Binding var viewModel: NewsViewModelProtocol
    @Environment(NewsViewModel.self) var viewModel
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            Text(NewsConstants.screenTitle.rawValue)
                .font(.system(size: 18, weight: .semibold))
                .padding()
            
            SearchView(searchText: $searchText)
            
            ScrollView(.vertical, showsIndicators: true) {
                ForEach(viewModel.articles) { article in
                    NewsCellView(
                        title: article.title,
                        description: article.description ?? "",
                        imageURL: article.urlToImage ?? ""
                    )
                }
            }
        }
        .onChange(of: searchText) { _, newValue in
                viewModel.searchArticles(with: newValue)
        }
    }
}

struct SearchView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search news", text: $searchText)
        }
        .padding(.horizontal, 12)
        .frame(height: 45)
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

struct NewsCellView: View {
    var title: String
    var description: String
    var imageURL: String?
        
    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                Text(description)
                    .font(.system(size: 15, weight: .medium))
                    .lineLimit(4)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.gray)
            }
                
            Spacer()
                
            if let imageURL, let url = URL(string: imageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 140, height: 140)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 140, height: 140)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .failure:
                        placeholderImage
                    @unknown default:
                        placeholderImage
                    }
                }
            } else {
                placeholderImage
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
    
    var placeholderImage: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 120)
            .foregroundColor(.gray)
    }
}

#Preview {
    NewsScreen(viewModel: NewsViewModel(objNetwork: NewsNetworkManager.shared))
}
