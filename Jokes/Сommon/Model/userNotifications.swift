//
//  notificationCIdentifier.swift
//  Jokes
//
//  Created by Кирилл on 20.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation

enum userNotifications {
    case local
}

func userNotificationsReturn(identifier:userNotifications) -> String{
    switch identifier {
    case .local:
        return "local"
    }
}
