//
//  UICollectionView + extention.swift
//  Jokes
//
//  Created by Кирилл on 14.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

extension UICollectionView{
    convenience init(frame:CGRect,flowLayout:UICollectionViewFlowLayout,isPagingEnabled:Bool = false,autoresizingMask:UIView.AutoresizingMask = [.flexibleHeight,.flexibleWidth],backgroundColor:UIColor = .whiteColor()){
        self.init(frame:frame,collectionViewLayout:flowLayout)
        self.isPagingEnabled = isPagingEnabled
        self.autoresizingMask = autoresizingMask
        self.backgroundColor = backgroundColor
    }
}
