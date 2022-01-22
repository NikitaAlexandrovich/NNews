//
//  EmptyView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 22.01.22.
//

import SwiftUI

struct EmptyServerView: View {
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = self.image {
                image
                    .imageScale(.large)
                    .font(.system(size: 70))
            }
            Text(text)
            Spacer()
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyServerView(text: "No news", image: Image(systemName: "sun.haze"))
    }
}
