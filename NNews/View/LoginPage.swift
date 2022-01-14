//
//  LoginPage.swift
//  NNews
//
//  Created by Никита Ходарёнок on 14.01.22.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct LoginPage: View {
    @State var isLoading: Bool = false
    
    @AppStorage("log_Status") var log_Status = false
    
    @AppStorage("userName") var userName = "NaN"
    
    var body: some View {
        Button {
            handleLoggin()
        } label : {
            HStack(spacing: 15){
                Image("googleImage")
                    .resizable()
//                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                Text("Sing In With Google")
                    .font(.title3)
                    .fontWeight(.medium)
                    .kerning(1.1)
            }
            .padding()
            .background(Capsule().strokeBorder(Color.black))
        }
        
//        if isLoading{
//            Color.black
//                .opacity(0.25)
//                .ignoresSafeArea()
//            ProgressView()
//                .font(.title2)
//                .frame(width: 60, height: 60)
//                .background(Color.white)
//                .cornerRadius(10)
//        }
    }
    
    func handleLoggin() {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        isLoading = true
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) {
            [self] user, err in
            
            if let error = err {
                isLoading = false
                print(error.localizedDescription)
                return
            }

            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                isLoading = false
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential){ result, err in
                isLoading = false
                if let error = err {
                    print(error.localizedDescription)
                    return
                }
                guard let user = result?.user else {
                    return
                }
                
                print(user.displayName ?? "Success")
                
                
                
                withAnimation{
                    userName = user.displayName ?? "Success"
                    log_Status = true
                }
            
            }
            
        }
        
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
            .previewDevice("iPhone 11")
    }
}

extension View {
    func getRootViewController()->UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
