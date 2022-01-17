//
//  BookmarkedNewsView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 17.01.22.
//

import SwiftUI

struct BookmarkedNewsView: View {
    
    var body: some View {
        VStack{
            Text("Тут выводятся после многоих проверок список сохраненных новостей")
        }
        .navigationBarTitle("Saved news", displayMode: .automatic)
    }
}

struct BookmarkedNewsView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkedNewsView()
    }
}
