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
    
    var body: some View {
        if log_Status{
            NavigationView{
                if isUnlocked {
                    BookmarkedNewsView()
                } else {
                    VStack{
                        Image(systemName: "faceid")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .padding(60)
                        
                        Text("Your falied biometric authentication!")
                            .font(.title3)
                            .kerning(1.3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top)
                            .multilineTextAlignment(.center)
                            
                        Spacer()
                            .frame(height: 40)
                        Button(action: {
                            authenticate()
                        }, label: {
                            Text("Try again")
                                .fontWeight(.semibold)
                                .kerning(1.3)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(Color.gray.opacity(0.7))
                                .cornerRadius(10)
                        })
                    }
                }
            }
            .onAppear(perform: authenticate)
            .onDisappear(perform: blockAuthenticate)
        }
        else {
            NotAuthorizedAccountView()
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
