//
//  AccountView.swift
//  NNews
//
//  Created by Никита Ходарёнок on 17.01.22.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct AccountView: View {
    
    @AppStorage("log_Status") var log_Status = false
    
    @StateObject private var notificationManager = NotificationManager()
    
    @EnvironmentObject var APIDataStore: APIDataStoreModel
    @EnvironmentObject var UserDataStore: UserDataStoreModel
    
    var body: some View {
        if log_Status{
            NavigationView{
                VStack(){
                    VStack(){
                        NavigationLink(destination: SecretView()) {
                            Image(uiImage: UserDataStore.accountInformation.userImage.load())
                            .renderingMode(.original)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color.white, lineWidth: 5))
                        }
                        Text("\(UserDataStore.accountInformation.userName)")
                            .fontWeight(.bold)
                            .padding()
                        Text("\(UserDataStore.accountInformation.userEmail)")
                            .opacity(0.5)
                        
                    }
                    .frame(alignment: .top)
                    Spacer()
                        .frame(height: 150)
                    Button(action: {
                        notificationManager.openApplicationSettings()
                    }, label: {
                        Text("Notification Settings")
                    })
                        .buttonStyle(RoundedCorners(color: Color.black))
                        .padding()
                    
                    Button(action: {
                        notificationManager.openApplicationSettings()
                    }, label: {
                        Text("FaceID/TouchID Settings")
                    })
                        .buttonStyle(RoundedCorners(color: Color.black))
                        .padding()
                    
                    Button(action: {
                        GIDSignIn.sharedInstance.signOut()
                        try? Auth.auth().signOut()
                        withAnimation{
                            log_Status = false
                        }
                    }, label: {
                        Text("Logout from account")
                            .foregroundColor(.red)
                    })
                        .padding()
                }
                .navigationBarTitle("Account", displayMode: .automatic)
            }
        }
        else {
            LoginPage()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    
    @StateObject static var APIDataStore = APIDataStoreModel.shared
    @StateObject static var UserDataStore = UserDataStoreModel.shared
    
    static var previews: some View {
        AccountView()
            .environmentObject(APIDataStore)
            .environmentObject(UserDataStore)
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
