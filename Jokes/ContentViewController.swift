//
//  ContentViewController.swift
//  Jokes
//
//  Created by Кирилл on 06.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    //MARK: Var
    private var bannerView:BannerView!

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpBannerView()
    }

    private func itemView(at index:Int)->UIImageView {
        let urls:[String] = ["https://images.pexels.com/photos/236047/pexels-photo-236047.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            "https://cdn.pixabay.com/photo/2015/12/01/20/28/fall-1072821__340.jpg",
            "https://images.pexels.com/photos/257360/pexels-photo-257360.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            "https://cdn.pixabay.com/photo/2017/04/09/09/56/avenue-2215317__340.jpg",
            "https://images.unsplash.com/photo-1500622944204-b135684e99fd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"]
        let itemImageView:UIImageView = UIImageView(frame: .zero)
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.setImage(path: urls[index])
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .scaleAspectFit
       
        return itemImageView
    }
}

//MARK: Setup
extension ContentViewController{
    private func setUpUI() {
        self.view.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.2431372549, blue: 0.3137254902, alpha: 1)
        bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.height))
        self.view.addSubview(bannerView)
    }
    
    private func setUpBannerView() {
        bannerView.reloadData(configuration: nil, numberOfItems: 5) { (bannerView, index) -> (UIView) in
           return self.itemView(at: index)
        }
    }
}
