//
//  NNewsApp.swift
//  NNews
//
//  Created by Никита Ходарёнок on 14.01.22.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct NNewsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject static var APIDataStore = APIDataStoreModel.shared
    @StateObject static var UserDataStore = UserDataStoreModel.shared
    @StateObject static var SaveNewsDataStore = SaveNewsDataStoreModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(NNewsApp.APIDataStore)
                .environmentObject(NNewsApp.UserDataStore)
                .environmentObject(NNewsApp.SaveNewsDataStore)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}
