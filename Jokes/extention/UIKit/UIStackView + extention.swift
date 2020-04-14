//
//  UIStackView + extention.swift
//  Jokes
//
//  Created by Кирилл on 05.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

extension UIStackView{
    
    convenience init(arrangedSubviews: [UIView],axis:NSLayoutConstraint.Axis,spacing:CGFloat = 0){
        self.init(arrangedSubviews: arrangedSubviews)
        
        self.axis = axis
        self.spacing = spacing
    }
}
