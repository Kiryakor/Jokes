//
//  UIViewController.swift
//  Jokes
//
//  Created by Кирилл on 14.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

extension UIViewController{
    convenience init(modalPresentationStyle:UIModalPresentationStyle,modalTransitionStyle: UIModalTransitionStyle = .coverVertical){
        self.init()
        self.modalPresentationStyle = modalPresentationStyle
        self.modalTransitionStyle = modalTransitionStyle
    }
}
