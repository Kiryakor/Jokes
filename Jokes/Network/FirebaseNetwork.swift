//
//  Firebase.swift
//  Jokes
//
//  Created by Кирилл on 07.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit
import Firebase

class FirebaseNetwork {
    func createUser(email:String,password:String,complition: @escaping(Bool)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                complition(false)
                return
            }
            complition(true)
        }
    }
}
