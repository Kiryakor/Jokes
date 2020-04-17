//
//  UILabel + extention.swift
//  Jokes
//
//  Created by Кирилл on 05.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

extension UILabel{
    
    convenience init(text:String,font:UIFont? = .avenir20()){
        self.init()
        
        self.font = font
        self.text = text
        self.textColor = .blackColor()
        self.tintColor = .blackColor()
    }
}
