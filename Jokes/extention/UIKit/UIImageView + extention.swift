//
//  UIImageView + extention.swift
//  Jokes
//
//  Created by Кирилл on 05.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

extension UIImageView{
    
    convenience init(image:UIImage?,contentMode:UIView.ContentMode){
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}
