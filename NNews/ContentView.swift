//
//  ContentView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 14.01.22.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct ContentView: View {
    @AppStorage("log_Status") var log_Status = false
    @AppStorage("userName") var userName = "NaN"
    
    var body: some View {
        if log_Status{
            
            // home view...
            NavigationView{
                VStack(spacing: 25){
                    Text("\(userName), You logged in")
                    Button("Logout from account"){
                        GIDSignIn.sharedInstance.signOut()
                        try? Auth.auth().signOut()
                        
                        withAnimation{
                            log_Status = false
                            
                        }
                    }
                }
            }
        }
        else {
            LoginPage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
