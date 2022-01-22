//
//  ServerErrorView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 22.01.22.
//

import SwiftUI

struct ServerErrorView: View {
    
    let text: String
    let retryAction: () -> ()
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "externaldrive.connected.to.line.below.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(70)
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            
            Button(action: retryAction) {
                Text("Retry")
            }
            .buttonStyle(RoundedCorners(color: Color.red))
        }
        .padding()
    }
}

struct ServerErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ServerErrorView(text: "Serv error") {
        }
    }
}
