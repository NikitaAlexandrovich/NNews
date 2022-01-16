//
//  NetworkWarningView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 16.01.22.
//

import SwiftUI

struct NetworkWarningView: View {
    
    @StateObject private var internetConnection = NetworkManager()
    
    var body: some View {
        VStack{
            Image(systemName: "wifi.slash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(70)
            
            Text("Your internet connection has been lost!")
                .font(.title3)
                .kerning(1.3)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)
                .multilineTextAlignment(.center)
                
            Spacer()
                .frame(height: 40)
            Button(action: {
                internetConnection.updateStatus()
            }, label: {
                Text("Require")
                    .fontWeight(.semibold)
                    .kerning(1.3)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(10)
            })
            
//            Group{
//                if internetConnection.isConnected {
//                    ContentView()
//                }
//            }
        }

    }
}

struct NetworkWarningView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkWarningView()
    }
}
