//
//  cellEnum.swift
//  Jokes
//
//  Created by Кирилл on 07.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation

enum cellEnum:String {
    case contentCV
}

func cellReturn(cell:cellEnum) -> String{
    switch cell {
    case .contentCV:
        return "contentCVCell"
    }
}
