//
//  ContentCVCell.swift
//  Jokes
//
//  Created by Кирилл on 08.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

class ContentCVCell: UICollectionViewCell {

    //MARK: Var
    var contentImage:ImageScrollView!
    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: func
    private func setup() {
        contentImage = ImageScrollView(frame: self.bounds)
        self.addSubview(contentImage)
        
        contentImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentImage.topAnchor.constraint(equalTo: self.topAnchor),
            contentImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setImage(image:UIImage){
        contentImage.set(image: image)
    }
    
    func contentCell(url:String){
        if Connectivity.isConnectedToInternet(){
            Server().loadImage(url: url) { [weak self] (data) in
                self?.setImage(image: UIImage(data: data)!)
            }
        }else{
            contentImage.set(image: #imageLiteral(resourceName: "notInternet"))
        }
    }
}
