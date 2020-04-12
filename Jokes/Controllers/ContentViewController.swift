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
    var dataList:[String] = []
    
    //MARK: Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
        
        loadData()
    }
    
    //MARK:
    func loadData(){
        server.request { [weak self](data) in
            self?.dataList += data
            self?.contentCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ContentViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReturn(cell: .contentCV), for: indexPath) as! ContentCVCell
        
        //И вообще убрать данные из этого класса
        //перекинуть в класс Cell и возвращать +[] или +[String]
        // indexPath.row передавать
        server.loadImage(url: dataList[indexPath.row]) { (data) in
            let image = UIImage(data: data)
            cell.setImage(image: image!)
        }
        
        if indexPath.row == dataList.count - 4 {
            loadData()
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
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
