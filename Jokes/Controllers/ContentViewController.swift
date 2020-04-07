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
    var contentCollectionView: UICollectionView!
    let infiniteSize = 100
    lazy var contentList: [UIColor] = {
        var colors = [UIColor]()
        for hue in stride(from: 0, to: 1.0, by: 0.25) {
            let color = UIColor(hue: CGFloat(hue), saturation: 1, brightness: 1, alpha: 1)
            colors.append(color)
        }
        return colors
    }()

    //MARK: Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ContentViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellEnum.contentCV.rawValue, for: indexPath)
        cell.backgroundColor = contentList[indexPath.row % contentList.count]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infiniteSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height + 7)
    }
}

//MARK: Setup
extension ContentViewController{
    func setup(){
        let midIndexPath = IndexPath(row: infiniteSize / 2, section: 0)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        contentCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height + 7), collectionViewLayout: flowLayout)
        contentCollectionView.scrollToItem(at: midIndexPath, at: .centeredHorizontally, animated: false)
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellEnum.contentCV.rawValue)
        contentCollectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        contentCollectionView.isPagingEnabled = true
        view.addSubview(contentCollectionView)
    }
}
