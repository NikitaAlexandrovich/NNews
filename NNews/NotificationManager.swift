//
//  CleanNotification.swift
//  NNews
//
//  Created by Никита Ходарёнок on 16.01.22.
//

import SwiftUI
import UserNotifications

final class NotificationManager: ObservableObject {
    func addNotification(){
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
                if success {
                    
                    let notificationMorningContent = UNMutableNotificationContent()
                    notificationMorningContent.title = "Good Morning!"
                    notificationMorningContent.body = "Read the Morning news over a cup of coffee."
                    notificationMorningContent.badge = NSNumber(value: 1)
                    notificationMorningContent.sound = .default
                                    
                    var datMorningComp = DateComponents()
                    datMorningComp.hour = 9
                    datMorningComp.minute = 0
                    let triggerMorning = UNCalendarNotificationTrigger(dateMatching: datMorningComp, repeats: true)
                    let requestMorning = UNNotificationRequest(identifier: "Morning News", content: notificationMorningContent, trigger: triggerMorning)
                    UNUserNotificationCenter.current().add(requestMorning) { (error : Error?) in
                        if let theError = error {
                            print(theError.localizedDescription)
                        }
                    }
                    
                    let notificationEveningContent = UNMutableNotificationContent()
                    notificationEveningContent.title = "Good Evening!"
                    notificationEveningContent.body = "Read All the News that happened today."
                    notificationEveningContent.badge = NSNumber(value: 1)
                    notificationEveningContent.sound = .default
                                    
                    var datEveningComp = DateComponents()
                    datEveningComp.hour = 18
                    datEveningComp.minute = 0
                    let triggerEvening = UNCalendarNotificationTrigger(dateMatching: datEveningComp, repeats: true)
                    let requestEvening = UNNotificationRequest(identifier: "Evening News", content: notificationEveningContent, trigger: triggerEvening)
                    UNUserNotificationCenter.current().add(requestEvening) { (error : Error?) in
                        if let theError = error {
                            print(theError.localizedDescription)
                        }
                    }
                }
                else if let error = error {
                    print(error.localizedDescription)
                }
            }
    }
      
    func cleanNotification(){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func openNotificationSettings(){
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options:[:], completionHandler: nil)
        }
    }
}
