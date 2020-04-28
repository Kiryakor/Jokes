//
//  Realm.swift
//  Jokes
//
//  Created by Кирилл on 18.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelpers{
    class func loadDataAndStringConvert()->[String]{
        let realm = try! Realm()
        let imageUrl: Results<localSaveData> = realm.objects(localSaveData.self)
        
        var data:[String] = []
        for i in imageUrl{
            data.append(i.imageUrl)
        }
        
        deleteAllData(data: imageUrl)
        return data
    }
    
    class func saveData(data:[String],startIndex:Int){
        let realm = try! Realm()
        var saveArray:[localSaveData] = []
        
        for index in startIndex..<data.count{
            saveArray.append(localSaveData(value: ["\(data[index])"]))
        }
        
        try! realm.write {
            realm.add(saveArray)
        }
    }
    
    class func deleteAllData(data:Results<localSaveData>){
        let realm = try! Realm() 
        
        try! realm.write {
            realm.delete(data)
        }
    }
}
