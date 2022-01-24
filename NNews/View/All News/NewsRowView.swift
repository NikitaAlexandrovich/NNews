//
//  NewsRowView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 18.01.22.
//

import SwiftUI

struct NewsRowView: View {
    
    @AppStorage("log_Status") var log_Status = false
    
    @EnvironmentObject var savedNews: SaveNewsDataStoreModel
    
    
    let newsRow: NewsArticle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1){
            VStack(alignment: .leading, spacing: 8){
                Text(newsRow.title)
                    .font(.headline)
                    .lineLimit(3)
            }
            .padding([.horizontal, .top, .bottom])
            
            AsyncImage(url: newsRow.imageURL){
                phase in
                switch phase{
                case .empty:
                    HStack{
                        Spacer()
                        ProgressView()
                            .frame(alignment: .center)
                        Spacer()
                    }
                    
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        .padding()
                    
                case .failure:
                    HStack{
                        Spacer()
                        Image(systemName: "photo.fill")
                            .imageScale(.large)
                        Spacer()
                    }
                @unknown default:
                    fatalError()
                }
            }
            .frame(minHeight: 200, maxHeight: 300)
            .clipped()
            
            VStack(alignment: .leading, spacing: 8){
                Text(newsRow.descriptionText)
                    .font(.subheadline)
                    .lineLimit(3)
                
                HStack{
                    Text(newsRow.captionText)
                        .lineLimit(1)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if log_Status{
                        Button{
                            if savedNews.checkStatus(for: newsRow) {
                                savedNews.deleteNews(for: newsRow)
                            } else {
                                savedNews.addNews(for: newsRow)
                            }
                        } label: {
                            Image(systemName: savedNews.checkStatus(for: newsRow) ? "bookmark.fill" : "bookmark")
                        }
                        .buttonStyle(.bordered)
                    }
                    Button{
                        sharedURL(url: newsRow.articleURL)
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.top)
            }
            .padding()
        }
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                // 4 5 11
                NewsRowView(newsRow: .previewData[18])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
        }
        .previewDevice("iPhone 11")
    }
}

extension View{
    
    func sharedURL(url: URL){
        let sharedActivity = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
                    .keyWindow?
                    .rootViewController?
                    .present(sharedActivity, animated: true)
    }
    
}
