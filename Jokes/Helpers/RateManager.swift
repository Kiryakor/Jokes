//
//  RateManager.swift
//  Jokes
//
//  Created by Кирилл on 16.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation
import StoreKit

class RateManager {
    
    class func incrementCount() {
        let count = UserDefaults.standard.integer(forKey: "run_count")
        if count < 17{
            UserDefaults.standard.set(count+1, forKey: "run_count")
            UserDefaults.standard.synchronize()
        }
    }
    
    class func showRateController() {
        let count = UserDefaults.standard.integer(forKey: "run_count")
        if count == 15{
            SKStoreReviewController.requestReview()
        }
    }
}
