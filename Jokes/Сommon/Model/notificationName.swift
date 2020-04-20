//
//  File.swift
//  Jokes
//
//  Created by Кирилл on 20.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation

enum notificationName {
    case longTapImageScrollView
}

func notificationNameReturn(name:notificationName) -> String{
    switch name {
    case .longTapImageScrollView:
        return "longTapImageScrollView"
    }
}
