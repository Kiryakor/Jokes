//
//  Firebase.swift
//  Jokes
//
//  Created by Кирилл on 07.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import Alamofire

class Server {
    class func createUser(email:String,password:String,complition: @escaping(Bool)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                complition(false)
                return
            }
            complition(true)
        }
    }
    
    class func loadImage(url:String,complition:@escaping(Data)->Void) {
        let storageRef = Storage.storage().reference(withPath: url)
        storageRef.getData(maxSize: 4*1024*1024) { (data, error) in
            guard let data = data, error == nil else { return }
            complition(data)
        }
    }
    
    class func request(imageCount:Int = 50,complition: @escaping([String])->Void){
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDToken(completion: { (token, error) in
            
            guard error == nil , let token = token else { return }
            
            let headers: HTTPHeaders = [
                "Token": token,
                "Accept": "application/json"
            ]

            AF.request("https://api.dukshtau.tech/api/get_images/\(imageCount)", headers: headers).responseJSON { response in
                switch response.result{
                case .success(let value):
                    guard let arrayData = value as? [String] else { return }
                    complition(arrayData)
                case .failure(let error):
                    //неверный формат
                    print(error.localizedDescription)
                    //print(error.isResponseSerializationError)
                    complition([])
                }
            }
        })
    }
}
