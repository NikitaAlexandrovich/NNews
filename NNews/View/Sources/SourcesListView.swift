//
//  SourcesListView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 26.01.22.
//

import SwiftUI

struct SourcesListView: View {
    
    let newsSources: [NewsSource]
    
    var body: some View {
        
        List{
            ForEach(newsSources) { source in
                NavigationLink(destination: SelectedSourceNewsView(source: source)) {
                    SourceRowView(source: source)
                }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .padding(.horizontal)
        .listStyle(.plain)
    }
}

struct SourcesListView_Previews: PreviewProvider {
    static var previews: some View {
        SourcesListView(newsSources: [NewsSource(id: "hhh", name: "hhbvbv")])
    }
}
