//
//  adUnitID.swift
//  Jokes
//
//  Created by Кирилл on 19.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation

enum adUnitID {
    case contentInterstitial
}

func adUnitIDReturn(cell:adUnitID) -> String{
    switch cell {
    case .contentInterstitial:
        return "ca-app-pub-3940256099942544/4411468910"
    }
}
