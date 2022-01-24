//
//  ButtonStyle.swift
//  NNews
//
//  Created by Никита Ходарёнок on 18.01.22.
//

import SwiftUI

struct RoundedCorners: ButtonStyle {
 
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var color: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        if colorScheme == .dark{
            configuration.label
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 1))
        } else{
            configuration.label
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                           .stroke(color, lineWidth: 1))
        }
    }
}
