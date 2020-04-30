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
    private var contentImage:ImageScrollView?
    private var loadLabel:UILabel?
    
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
        guard let contentImage = contentImage else { return }
        self.addSubview(contentImage)
        
        contentImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentImage.topAnchor.constraint(equalTo: self.topAnchor),
            contentImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setImage(image:UIImage){
        contentImage!.set(image: image)
    }
    
    func contentCell(url:String){
        loadSetup()
        Server.loadImage(url: url) { [weak self] (data) in
            self?.loadLabel?.isHidden = true
            self?.setImage(image: UIImage(data: data)!)
        }
    }
    
    private func loadSetup(){
        loadLabel = UILabel(text: "Мем грузится")
        guard let loadLabel = loadLabel else { return }
        self.addSubview(loadLabel)
        
        loadLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loadLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
