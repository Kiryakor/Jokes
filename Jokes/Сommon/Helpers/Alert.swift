//
//  Alert.swift
//  Jokes
//
//  Created by Кирилл on 17.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

class Alert {
    class func alertOneAction(titleAlert:String?,
                        messageAlert:String?,
                        preferredStyle:UIAlertController.Style,
                        titleAction:String?,
                        styleAction:UIAlertAction.Style,
                        hander:((UIAlertAction)->Void)?
    ) -> UIAlertController{
        
        let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: preferredStyle)
        let action = UIAlertAction(title: titleAction, style: styleAction, handler: hander)
        alert.addAction(action)
        return alert
    }
}
