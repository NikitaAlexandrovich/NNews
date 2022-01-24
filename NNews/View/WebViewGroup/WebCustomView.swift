//
//  WebCustomPresentation.swift
//  NNews
//
//  Created by Никита Ходарёнок on 20.01.22.
//

import SwiftUI

struct WebCustomView: View {
    
    
    let newsArticle: NewsArticle
    
    @StateObject var model = WebViewModel()
    @State private var isSharePresented: Bool = false
    
    @AppStorage("log_Status") var log_Status = false
    
    @EnvironmentObject var savedNews: SaveNewsDataStoreModel
        
    var body: some View {
        NavigationView{
            WebView(webView: model.webView)
                .onAppear{
                    model.updateURL(urlNew: newsArticle.articleURL)
                }
                .edgesIgnoringSafeArea(.bottom)
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button(action: {
                            self.isSharePresented = true
                        }, label: {
                            Image(systemName: "square.and.arrow.up")
                        })
                        .sheet(isPresented: $isSharePresented, onDismiss: {
                            
                        }, content: {
                            ActivityViewController(activityItems: [newsArticle.articleURL])
                        })
                        
                        Spacer()
                        
                        if log_Status{
                            Button(action: {
                                if savedNews.checkStatus(for: newsArticle) {
                                    savedNews.deleteNews(for: newsArticle)
                                } else {
                                    savedNews.addNews(for: newsArticle)
                                }
                            }) {
                                Image(systemName: savedNews.checkStatus(for: newsArticle) ? "bookmark.fill" : "bookmark")
                            }
                        }
                    }
                }
                .navigationBarHidden(true)
        }
    }
}

struct WebCustomPresentation_Previews: PreviewProvider {
    static var previews: some View {
        WebCustomView(newsArticle: NewsArticle.previewData[0])
    }
}
