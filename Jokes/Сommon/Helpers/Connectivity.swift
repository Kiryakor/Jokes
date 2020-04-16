//
//  File.swift
//  Jokes
//
//  Created by Кирилл on 16.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
