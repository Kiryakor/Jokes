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
    
    func setImage(path:String) {
        guard let url:URL = URL(string: path) else { return }
        DispatchQueue.global(qos: .utility).async {
            guard let data:Data = try? Data(contentsOf: url) , let image:UIImage = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
