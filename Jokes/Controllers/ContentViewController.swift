//
//  ContentViewController.swift
//  Jokes
//
//  Created by Кирилл on 06.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class ContentViewController: UIViewController {
    
    //MARK: Var
    var contentCollectionView: UICollectionView!
    let server = Server()
    let numberOfItemsInAPage = 5
    var page = 0
    var numbers:[Int]?
    
    //MARK: Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
        
        self.numbers = self.prepareList()
        self.contentCollectionView.reloadData()
        
        server.request()
    }
    
     //MARK: func
    func prepareList() -> [Int] {
        var list:[Int] = []
        
        let lowerIndex = self.page * numberOfItemsInAPage
        let upperIndex = lowerIndex + numberOfItemsInAPage
        
        for number in lowerIndex..<upperIndex {
            list.append(number)
        }
        return list
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ContentViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReturn(cell: .contentCV), for: indexPath) as! ContentCVCell
        cell.setImage(image: #imageLiteral(resourceName: "welcome"))
        
        if indexPath.row == self.numbers!.count - 1 {
            DispatchQueue.main.async {
                self.page = self.page + 1
                let newList = self.prepareList()
                self.numbers?.append(contentsOf: newList)
                self.contentCollectionView.reloadData()
            }
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let num = self.numbers else { return 0 }
        return num.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height + 7)
    }
}

//MARK: Setup
extension ContentViewController{
    func setup(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        contentCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height + 7), collectionViewLayout: flowLayout)
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.register(ContentCVCell.self, forCellWithReuseIdentifier: cellReturn(cell: .contentCV))
        contentCollectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        contentCollectionView.isPagingEnabled = true
        view.addSubview(contentCollectionView)
    }
}
