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
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
        
            let headers: HTTPHeaders = [
                "Authorization": idToken!,
                "Accept": "application/json"
            ]

            AF.request("http://api.dukshtau.tech/api/get_images/1", headers: headers).responseJSON { response in
                debugPrint(response)
            }
        }
    }
}
