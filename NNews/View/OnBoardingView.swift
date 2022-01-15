//
//  OnBoardingView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 15.01.22.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("curentPage") var curentPage = 1
    var body: some View {
        ZStack{
            if curentPage == 1 {
                ScreenView(image: "firstOnBoarding", title: "Step 1", detail: "Instruction for 1", bgColor: .cyan)
                    .transition(.move(edge: .leading))
            }
            if curentPage == 2 {
                ScreenView(image: "firstOnBoarding", title: "Step 2", detail: "Instruction for 2", bgColor: .yellow)
                    .transition(.move(edge: .leading))
            }
            if curentPage == 3 {
                ScreenView(image: "firstOnBoarding", title: "Step 3", detail: "Instruction for 3", bgColor: .red)
                    .transition(.move(edge: .leading))
            }
        }
        .overlay{
            Button(action: {
                withAnimation(.easeInOut){
                    if curentPage <= totalPages{
                        curentPage += 1
                        
                    }else{
                        curentPage = 1
                    }
                }
            }, label: {
                HStack{
                    if curentPage == 3{
                        Text("Start reading")
                            .fontWeight(.semibold)
                            .kerning(1.3)
                        Image(systemName: "newspaper")
                    }
                    else {
                        Text("Next Step")
                            .fontWeight(.semibold)
                            .kerning(1.3)
                        Image(systemName: "chevron.right")
                    }
                    
                }
                .foregroundColor(.white)
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.black.opacity(0.4))
                .cornerRadius(10)
            })
            .padding(.bottom, 5)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
            .previewDevice("iPhone 11")
    }
}

struct ScreenView: View{
    
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    
    @AppStorage("curentPage") var curentPage = 1
    
    var body: some View{
        VStack(spacing: 20){
            Spacer()
                .frame(height: 5)
            HStack{
                if curentPage == 1 {
                    Text("Welcome to NNews")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.4)
                }
                else{
                    // Back button
                    Button(action: {
                        withAnimation(.easeInOut){
                            curentPage -= 1
                        }
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    })
                }
                
                Spacer()
                
                // Skip button
                Button(action: {
                    withAnimation(.easeInOut){
                        curentPage = 4
                    }
                }, label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.3)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(10)
                })
            }
            .foregroundColor(.black)
            .padding()
            
            // MARK: add .frame(height: int) when add normal image
            Spacer()
                .frame(height: 10)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)
            
            Text(detail)
                .fontWeight(.semibold)
                .kerning(1.2)
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 120)
        }
        .background(bgColor).ignoresSafeArea()
    }
}

var totalPages = 3
