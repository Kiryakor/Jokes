//
//  Realm.swift
//  Jokes
//
//  Created by Кирилл on 18.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation
import RealmSwift

//сделать через <T>
class RealmHelpers{
    class func loadDataAndStringConvert()->[String]{
        let realm = try! Realm()
        var imageUrl: Results<hrefList>!
        imageUrl = realm.objects(hrefList.self)
        var data:[String] = []
        for i in imageUrl{
            data.append(i.task)
        }
        deleteAllData(data: imageUrl)
        return data
    }
    
    class func saveData(data:[String],startIndex:Int){
        var saveArray:[hrefList] = []
        for index in startIndex..<data.count{
            saveArray.append(hrefList(value: ["\(data[index])"]))
        }
        let realm = try! Realm()
        try! realm.write {
            realm.add(saveArray)
        }
    }
    
    class func deleteAllData(data:Results<hrefList>){
        let realm = try! Realm() 
        try! realm.write {
            realm.delete(data)
        }
    }
}
