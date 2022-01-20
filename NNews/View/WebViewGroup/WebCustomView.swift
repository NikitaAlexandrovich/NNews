//
//  WebCustomPresentation.swift
//  NNews
//
//  Created by Никита Ходарёнок on 20.01.22.
//

import SwiftUI

struct WebCustomView: View {
    
    let urlNews: URL
    
    @StateObject var model = WebViewModel()
    @State private var isSharePresented: Bool = false
        
    var body: some View {
        NavigationView{
            WebView(webView: model.webView)
                .onAppear{
                    model.updateURL(urlNew: urlNews)
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
                            ActivityViewController(activityItems: [urlNews])
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            // TODO: Create toogle bookmark
                        }) {
                            Image(systemName: "bookmark")
                        }
                    }
                }
                .navigationBarHidden(true)
        }
        
        
    }
}

struct WebCustomPresentation_Previews: PreviewProvider {
    static var previews: some View {
        WebCustomView(urlNews: URL(string: "http//bing.com")!)
    }
}
