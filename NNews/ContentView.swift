//
//  ContentView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 14.01.22.
//

import SwiftUI
import Firebase
import GoogleSignIn
import UserNotifications

struct ContentView: View {
    @AppStorage("log_Status") var log_Status = false
    @AppStorage("userName") var userName = "NaN"
    @AppStorage("userImage") var userImage = URL(fileURLWithPath: "")
    @AppStorage("curentPage") var curentPage = 1

    @StateObject private var notificationManager = NotificationManager()
    
    var body: some View {
        if curentPage > 3{
            if log_Status{
                // home view...
                NavigationView{
                    VStack(spacing: 25){
                        Image(uiImage: userImage.load())
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color.white, lineWidth: 5))
                        
                        Text("\(userName), You logged in")
                        Button("Logout from account"){
                            GIDSignIn.sharedInstance.signOut()
                            try? Auth.auth().signOut()
                            withAnimation{
                            log_Status = false
                            }
                        }
                        Button("Notification Settings"){
                            notificationManager.openNotificationSettings()
                        }

                    }
                }
                .onAppear {
                    notificationManager.cleanNotification()
                }
            }
            else {
                LoginPage()
            }
        }
        else{
            OnBoardingView()
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension URL{
    func load()->UIImage{
        do{
            let data: Data = try Data(contentsOf: self)
            return UIImage(data: data) ?? UIImage()
        }
        catch{}
        return UIImage()
    }
}
