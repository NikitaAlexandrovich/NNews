//
//  EmptySaveNewsView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 24.01.22.
//

import SwiftUI

struct EmptySaveNewsView: View {
    var body: some View {
        VStack{
            Image(systemName: "bookmark.slash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(120)
            Text("No Saved News")
                .bold()
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
                
        }
    }
}

struct EmptySaveNewsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptySaveNewsView()
    }
}
