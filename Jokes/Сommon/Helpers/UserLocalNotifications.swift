//
//  localNotifications.swift
//  Jokes
//
//  Created by Кирилл on 20.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation
import UserNotifications

class UserLocalNotifications{
    
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
        let contentList:[String] = ["Дожили... Новая подборка мемов уже доступна для тебя",
                                    "Кура, булка, греча, поребрик... А у наc новая подберка мемов для тебя",
                                    "Вечер в ладу... у нас новости для тебя - заходи",
                                    "Прошло успешно... Смотри новые мемы в приложении",
                                    "Come on. Ты не знал? Мемы не спят",
                                    "Yo, свежие новинки подъехали"]
        
        let content = UNMutableNotificationContent()
        content.title = ""
        content.body = contentList.randomElement()!
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60*60*10, repeats: false)
        
        let request = UNNotificationRequest(identifier: userNotificationsReturn(identifier: .local) , content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription ?? "error notificationCenter")
        }
    }
}
