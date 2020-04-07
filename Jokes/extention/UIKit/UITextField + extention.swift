//
//  UITextField + extention.swift
//  Jokes
//
//  Created by Кирилл on 07.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

extension UITextField{
    func checkText() -> String?{
        if self.text!.isEmpty {
            return nil
        }
        return self.text
    }
    
    func errorAnimation(){
           let animation = CABasicAnimation(keyPath: "position")
           animation.duration = 0.05
           animation.repeatCount = 10
           animation.autoreverses = true
           animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
           animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
           self.layer.add(animation, forKey: "position")
           self.text = nil
       }
}
