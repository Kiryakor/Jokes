//
//  localNotifications.swift
//  Jokes
//
//  Created by Кирилл on 20.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation
import UserNotifications

class UserNotificationsHelper{
    
    class func setup(){
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert,.sound,.badge]) { (granted, error) in
            guard granted else { return }
            notificationCenter.getNotificationSettings { (setting) in
                guard setting.authorizationStatus == .authorized else { return }
            }
        }
    }
    
    class func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Мемы ждут"
        content.body = "Новая подборка мемов уже готова для тебя "
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: userNotificationsReturn(identifier: .local) , content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription ?? "error notificationCenter")
        }
    }
}
