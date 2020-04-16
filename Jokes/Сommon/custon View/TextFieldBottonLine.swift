//
//  TextFieldBottonLine.swift
//  Jokes
//
//  Created by Кирилл on 05.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

class TextFieldBottonLine: UITextField {
    
    convenience init(font: UIFont?, backgroundColor:UIColor) {
        self.init()
        
        self.font = font
        self.borderStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var bottomView = UIView()
        bottomView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        bottomView.backgroundColor = backgroundColor
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
