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
        
    @AppStorage("log_Status") var log_Status = false
    
//    @AppStorage("userName") var userName = "NaN"
//    @AppStorage("userEmail") var userEmail = "NaN"
//    @AppStorage("userImage") var userImage = URL(fileURLWithPath: "")
    
    @EnvironmentObject var UserDataStore: UserDataStoreModel
    
    @StateObject private var notificationManager = NotificationManager()
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                Button(action: {
                    handleLoggin()
                }, label: {
                    HStack(spacing: 15){
                        Image("googleImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28, height: 28)
                        Text("Sing In With Google")
                    }
                })
                    .buttonStyle(RoundedCorners(color: Color.black))
                    .padding()

                Button(action: {
                    notificationManager.openApplicationSettings()
                }, label: {
                    Text("Notification Settings")
                })
                    .buttonStyle(RoundedCorners(color: Color.black))
                    .padding()
            }
            .navigationBarTitle("Account", displayMode: .automatic)
        }
    }
    
    func handleLoggin() {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) {
            [self] user, err in
            
            if let error = err {
                print(error.localizedDescription)
                return
            }

            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential){ result, err in
                if let error = err {
                    print(error.localizedDescription)
                    return
                }
                guard let user = result?.user else {
                    return
                }

                withAnimation{
                    
                    UserDataStore.accountInformation.userImage = user.photoURL ?? URL(fileURLWithPath: "")
                    UserDataStore.accountInformation.userName = user.displayName ?? "NaN"
                    UserDataStore.accountInformation.userEmail = user.email ?? "NaN"
                    UserDataStore.UserDataUpdated()
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
