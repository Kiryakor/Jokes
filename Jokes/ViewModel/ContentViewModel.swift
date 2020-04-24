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
    private var maxViewedIndex:Int = 0
    private var activeIndex:Int = 0
    private var dataList:[String] = []
    
    var sizeData: Int{
        get {
            dataList.count
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return dataList.count
    }
    
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
    
    func saveDataRealm(){
        RealmHelpers.saveData(data: dataList, startIndex: maxViewedIndex)
    }
    
    func returnData(index:Int) -> String{
        return dataList[index]
    }
    
    func sharing(vc:UIViewController){
        Server.loadImage(url: dataList[activeIndex]) { (data) in
            Sharing.share(on: vc, text: "Infinity meme", image: UIImage(data: data), link: nil)
        }
    }
}
