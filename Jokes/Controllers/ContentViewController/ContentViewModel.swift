//
//  ViewModel.swift
//  Jokes
//
//  Created by Кирилл on 24.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation
import UIKit

class ContentViewModel {
    var maxViewedIndex:Int = 0
    var activeIndex:Int = 0
    var dataList:[String] = []
    
    
    func loadDataServer(complition:@escaping()->Void){
        Server.request { [weak self](data) in
            if data.count != 0{
                self?.dataList += data
            }
            complition()
        }
    }
    
    func loadDataRealm(complition:@escaping()->Void){
        dataList += RealmHelpers.loadDataAndStringConvert()
        complition()
    }
    
    func cellHelper(index:Int,complition:@escaping()->Void){
        maxViewedIndex = max(maxViewedIndex, index)
        activeIndex = index
        
        if index == dataList.count - 4 {
            loadDataServer(complition: complition)
        }
    }
}
