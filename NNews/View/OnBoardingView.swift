//
//  OnBoardingView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 15.01.22.
//

import SwiftUI

struct OnBoardingView: View {
    
    @AppStorage("curentPage") var curentPage = 1
    @StateObject private var notificationManager = NotificationManager()
    
    var body: some View {
        ZStack{
            if curentPage == 1 {
                ScreenView(image: "topHeadlines", title: "Headers", detail: "", bgColor: .white)
                    .transition(.move(edge: .leading))
            }
            if curentPage == 2 {
                ScreenView(image: "sourceNews", title: "News Author", detail: "It is possible to select a source and view a list of the latest available news.", bgColor: .white)
                    .transition(.move(edge: .leading))
            }
            if curentPage == 3 {
                ScreenView(image: "faceID", title: "Bookmark Protection", detail: "Use FaceID or TouchID for secure You bookmarked news.", bgColor: .white)
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
                    if curentPage == 4 {
                        notificationManager.addNotification()
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
    @StateObject private var notificationManager = NotificationManager()
    
    var body: some View{
        VStack(spacing: 20){
            Spacer()
                .frame(height: 5)
            HStack{
                if curentPage == 1 {
                    Text("Welcome to NNews")
                        .foregroundColor(.black)
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
                    notificationManager.addNotification()
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
            
            Spacer()
                .frame(height: 1)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1))
                .shadow(radius: 4)
                .padding(.horizontal)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)
            
            if curentPage == 1{
                Text("Browse Top Headlines with a choice of country \(Image(systemName: "location")) and search category \(Image(systemName: "filemenu.and.selection")).")
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .kerning(1.2)
                    .multilineTextAlignment(.center)
            }
            else {
                Text(detail)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .kerning(1.2)
                    .multilineTextAlignment(.center)
            }
            Spacer(minLength: 120)
        }
        .background(bgColor).ignoresSafeArea()
    }
}

var totalPages = 3
