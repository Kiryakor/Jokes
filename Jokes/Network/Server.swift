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
    
    func request(){
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDToken(completion: { (token, error) in
            
            guard error == nil , let token = token else { return }
            
            let headers: HTTPHeaders = [
                "Token": token,
                "Accept": "application/json"
            ]
            
            AF.request("https://api.dukshtau.tech/api/get_images/2", headers: headers).responseJSON { response in
                print(response)
                // debugPrint(response)
            }
        })
    }
}
