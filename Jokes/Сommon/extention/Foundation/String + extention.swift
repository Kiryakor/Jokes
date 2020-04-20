//
//  String + extention.swift
//  Jokes
//
//  Created by Кирилл on 17.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
