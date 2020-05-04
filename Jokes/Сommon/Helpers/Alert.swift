//
//  Alert.swift
//  Jokes
//
//  Created by Кирилл on 17.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

class Alert {
    class func errorServerAlert(on viewController: UIViewController & LoadDataProtocol){
        let alert = UIAlertController(title: nil, message: "Ошибка сервера".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "Повторить попытку".localized, style: .default) { [weak viewController](alert) in
                viewController?.loadPathImageServer()
        }
        alert.addAction(action)
        viewController.present(alert,animated:true)
    }
    
    class func errorInternetAlert(on viewController: UIViewController & LoadDataProtocol & ContentCollectionView){
        let alert = UIAlertController(title: nil, message: "Отсутствует подключение к интернету".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "Повторить попытку".localized, style: .default) { [weak viewController](alert) in
            if !Connectivity.isConnectedToInternet(){
                errorInternetAlert(on: viewController!)
            }else{ viewController?.contentCollectionView.reloadData() }
        }
        alert.addAction(action)
        viewController.present(alert,animated:true)
    }
}
