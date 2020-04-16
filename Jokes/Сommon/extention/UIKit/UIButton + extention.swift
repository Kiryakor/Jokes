//
//  UIButton + extention.swift
//  Jokes
//
//  Created by Кирилл on 05.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

extension UIButton{
    
    convenience init(title:String,
                     titleColor: UIColor,
                     backgroundColor:UIColor,
                     font:UIFont?,
                     cornerRadius:CGFloat = 0,
                     isShadow:Bool = false
    ){
        self.init(type: .system)

        self.setTitle(title,for: .normal)
        self.setTitleColor(titleColor,for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        
        if isShadow{
            self.layer.shadowColor = UIColor.blackColor().cgColor
            self.layer.shadowRadius = 5
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
}
