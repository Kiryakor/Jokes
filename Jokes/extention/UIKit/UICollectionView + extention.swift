//
//  UICollectionView + extention.swift
//  Jokes
//
//  Created by Кирилл on 14.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

extension UICollectionView{
    convenience init(frame:CGRect,scrollDirection:UICollectionView.ScrollDirection = .horizontal,minimumLineSpacing:CGFloat = 0,isPagingEnabled:Bool = false,autoresizingMask:UIView.AutoresizingMask = [.flexibleHeight,.flexibleWidth]){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = scrollDirection
        flowLayout.minimumLineSpacing = minimumLineSpacing
        
        self.init(frame:frame,collectionViewLayout:flowLayout)
        self.isPagingEnabled = isPagingEnabled
        self.autoresizingMask = autoresizingMask
    }
}
