//
//  ButtonStyle.swift
//  NNews
//
//  Created by Никита Ходарёнок on 18.01.22.
//

import SwiftUI

struct RoundedCorners: ButtonStyle {
 
    var color: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .padding(10)
            .overlay(
                   RoundedRectangle(cornerRadius: 10)
                       .stroke(color, lineWidth: 1)
               )
        }
}
