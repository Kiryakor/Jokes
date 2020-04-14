//
//  UICollectionViewFlowLayout + extention.swift
//  Jokes
//
//  Created by Кирилл on 14.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

extension UICollectionViewFlowLayout{
    convenience init(scrollDirection:UICollectionView.ScrollDirection,minimumLineSpacing:CGFloat){
        self.init()
        self.scrollDirection = scrollDirection
        self.minimumLineSpacing = minimumLineSpacing
    }
}
