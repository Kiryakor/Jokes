//
//  notificationCIdentifier.swift
//  Jokes
//
//  Created by Кирилл on 20.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation

enum userNotificationCIdentifier {
    case local
}

func userNotificationCIdentifierReturn(identifier:userNotificationCIdentifier) -> String{
    switch identifier {
    case .local:
        return "local"
    }
}
