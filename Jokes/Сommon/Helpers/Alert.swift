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
    
    class func errorServerAlert(on viewController: UIViewController & LoadDataProtocol){
        let alert = Alert.alertOneAction(titleAlert: nil,
                                         messageAlert: "Ошибка сервера".localized,
                                         preferredStyle: .alert,
                                         titleAction: "Повторить попытку".localized,
                                         styleAction: .default) { [weak viewController](alert) in
                                                viewController?.loadDataServer()
                                        }
        viewController.present(alert,animated:true)
    }
    
    class func errorInternetAlert(on viewController: UIViewController & LoadDataProtocol & ContentCollectionView){
        let alert = Alert.alertOneAction(titleAlert: nil,
                                         messageAlert: "Отсутствует подключение к интернету".localized,
                                         preferredStyle: .alert,
                                         titleAction: "Повторить попытку".localized,
                                         styleAction: .default) { [weak viewController](alert) in
                                            if !Connectivity.isConnectedToInternet(){
                                                errorInternetAlert(on: viewController!)
                                            }else{
                                                viewController?.contentCollectionView.reloadData()
                                            }
                                        }
        viewController.present(alert,animated:true)
    }
}
