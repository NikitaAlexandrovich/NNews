//
//  ContentView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 14.01.22.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("curentPage") var curentPage = 1

    @StateObject private var notificationManager = NotificationManager()
    @StateObject private var internetConnection = NetworkManager()
    
    var body: some View {
        if curentPage > 3{
            Group{
                if internetConnection.isConnected{
                    TabView{
                        NewsTabView()
                            .tabItem{
                                Label("News", systemImage: "newspaper")
                            }
                        SearchNewsView()
                            .tabItem{
                                Label("Search", systemImage: "magnifyingglass")
                            }
                        SourceNewsView()
                            .tabItem{
                                Label("Sources", systemImage: "tray.full")
                            }
                        BookmarkNewsTabView()
                            .tabItem{
                                Label("Saved", systemImage: "bookmark")
                            }
                        AccountView()
                            .tabItem{
                                Label("Account", systemImage: "person.circle")
                            }
                    }
                    .onAppear {
                        notificationManager.cleanNotification()
                        internetConnection.updateStatus()
                    }
                }
                else{
                    NetworkWarningView()
                }
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
