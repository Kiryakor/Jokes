//
//  Server.swift
//  Jokes
//
//  Created by Кирилл on 08.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation
import Alamofire
import Firebase

class Server {
    //запрос на сервер
    func request(){
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDToken(completion: { (token, error) in
            
            guard error == nil , let token = token else { return }
            
            let headers: HTTPHeaders = [
                "Token": token,
                "Accept": "application/json"
            ]

            AF.request("https://api.dukshtau.tech/api/get_images/2", headers: headers).responseJSON { response in
                debugPrint(response)
                
                switch response.result{
                case .success(let value):
                    print(value)
                    //guard let arrayData = value as? [Any] else { return }
                    //print(arrayData)
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
    //loadImage
    func loadImage(url:String,complition:@escaping(Data?)->Void) {
        guard let url = URL(string: url) else {
            complition(nil)
            return
        }

        DispatchQueue.global(qos: .utility).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                complition(data)
            }
        }
    }
}
