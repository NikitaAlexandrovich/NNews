//
//  BookmarkNewsView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 17.01.22.
//

import SwiftUI
import LocalAuthentication

struct BookmarkNewsTabView: View {
    
    @AppStorage("log_Status") var log_Status = false
    
    @State private var isUnlocked = false
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var savedNews: SaveNewsDataStoreModel
    
    var body: some View {
        if !savedNews.getSavedNewsForUser().isEmpty {
            if log_Status{
                NavigationView{
                    if isUnlocked {
                        BookmarkedNewsView()
                            .onDisappear(perform: blockAuthenticate)
                    } else {
                        VStack{
                            Image(systemName: "faceid")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                                .padding(60)
                            if colorScheme == .dark{
                                Text("Your falied biometric authentication!")
                                    .font(.title3)
                                    .kerning(1.3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.top)
                                    .multilineTextAlignment(.center)
                            }
                            else{
                                Text("Your falied biometric authentication!")
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
                                authenticate()
                            }, label: {
                                Text("Try again")
                            })
                                .buttonStyle(RoundedCorners(color: Color.black))
                                .padding()
                        }
                    }
                }
                .onAppear(perform: authenticate)
                .onDisappear(perform: blockAuthenticate)
            }
            else {
                NotAuthorizedAccountView()
                    .onAppear(perform: blockAuthenticate)
            }
        }
        else {
            EmptySaveNewsView()
                .onAppear(perform: blockAuthenticate)
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                if success {
                    self.isUnlocked = true
                } else {
                    self.isUnlocked = false
                }
            }
        } else {
            // no biometrics
        }
    }
    
    func blockAuthenticate(){
        isUnlocked = false
    }
}

struct BookmarkNewsView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkedNewsView()
    }
}
