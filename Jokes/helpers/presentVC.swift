//
//  presentVC.swift
//  Jokes
//
//  Created by Кирилл on 14.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

class Present {
    func presentViewController(vc:UIViewController,modalPresentationStyle:UIModalPresentationStyle = .fullScreen,modalTransitionStyle: UIModalTransitionStyle = .coverVertical,complition:@escaping(UIViewController)->Void) {
        vc.modalPresentationStyle = modalPresentationStyle
        vc.modalTransitionStyle = modalTransitionStyle
        complition(vc)
    }
}
