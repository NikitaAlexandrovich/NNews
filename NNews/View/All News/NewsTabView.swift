//
//  NewsTabView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 18.01.22.
//

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var getNewsModel = GetNewsModel()
    
    var body: some View {
        NavigationView{
            NewsListView(newsArticles: newsArticle)
                .overlay(overlayView)
                .refreshable {
                    updateNews()
                }
                .onAppear{
                    updateNews()
                }
                .onChange(of: getNewsModel.selectedCountry, perform: { news in
                    updateNews()
                })
                .onChange(of: getNewsModel.selectedCategory, perform: { news in
                    updateNews()
                })
                .navigationBarTitle(getNewsModel.selectedCategory.topHeadlinesGet, displayMode: .automatic)
                .navigationBarItems(trailing: categoryMenu)
                .navigationBarItems(trailing: countryMenu)
        }
    }
    
    private var newsArticle: [NewsArticle] {
        if case let .success(articles) = getNewsModel.phase {
            return articles
        } else {
            return []
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        
        switch getNewsModel.phase {
        case .empty:
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            EmptyServerView(text: "Response contains no news", image: Image(systemName: "pip.remove"))
        case .failure(let error):
            ServerErrorView(text: error.localizedDescription){
                updateNews()
            }
        default: EmptyView()
        }
    }
    
    private func updateNews(){
        Task{
            await getNewsModel.loadNews()
        }
    }
    
    private var countryMenu: some View{
        Menu{
            Picker("Location", selection: $getNewsModel.selectedCountry){
                ForEach(Country.allCases){
                    Text($0.getLocation)
                }
            }
        } label: {
            Image(systemName: "location")
        }
    }
    
    private var categoryMenu: some View{
        Menu{
            Picker("Location", selection: $getNewsModel.selectedCategory){
                ForEach(Category.allCases){
                    Text($0.topHeadlinesGet)
                }
            }
        } label: {
            Image(systemName: "filemenu.and.selection")
        }
    }
    
}

struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView(getNewsModel: GetNewsModel(articles: NewsArticle.previewData))
    }
}
