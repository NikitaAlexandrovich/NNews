//
//  NewsListView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 17.01.22.
//

import SwiftUI

struct NewsListView: View {
    var body: some View {
        VStack{
            Text("News List View")
        }
        // in title in future use (headlines or theme news)
        .navigationBarTitle("News", displayMode: .automatic)
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
    }
}
