//
//  NetworkWarningView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 16.01.22.
//

import SwiftUI

struct NetworkWarningView: View {
    
    @StateObject private var internetConnection = NetworkManager()
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        VStack{
            Image(systemName: "wifi.slash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(70)
            
            if colorScheme == .dark{
                Text("Your internet connection has been lost!")
                    .font(.title3)
                    .kerning(1.3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top)
                    .multilineTextAlignment(.center)
            }
            else{
                Text("Your internet connection has been lost!")
                    .font(.title3)
                    .kerning(1.3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
                .frame(height: 40)
            Button(action: {
                internetConnection.updateStatus()
            }, label: {
                Text("Require")
            })
                .buttonStyle(RoundedCorners(color: Color.black))
                .padding()
        }

    }
}

struct NetworkWarningView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkWarningView()
    }
}
