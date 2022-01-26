//
//  SourceRowView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 26.01.22.
//

import SwiftUI

struct SourceRowView: View {
    
    let source: NewsSource
    
    var body: some View {
        HStack{
            Text(source.name)
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

struct SourceRowView_Previews: PreviewProvider {
    static var previews: some View {
        SourceRowView(source:  NewsSource(id: "someID", name: "SomeName"))
    }
}
