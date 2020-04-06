//
//  ContentViewController.swift
//  Jokes
//
//  Created by Кирилл on 06.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    var colorCollectionView: UICollectionView!
    
    let infiniteSize = 10000

    lazy var colorList: [UIColor] = {
        var colors = [UIColor]()
        for hue in stride(from: 0, to: 1.0, by: 0.25) {
            let color = UIColor(hue: CGFloat(hue), saturation: 1, brightness: 1, alpha: 1)
            colors.append(color)
        }
        return colors
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let midIndexPath = IndexPath(row: infiniteSize / 2, section: 0)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        colorCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height + 7), collectionViewLayout: flowLayout)
        colorCollectionView.scrollToItem(at: midIndexPath, at: .centeredHorizontally, animated: false)
        colorCollectionView.dataSource = self
        colorCollectionView.delegate = self
        colorCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ColorCell")
        colorCollectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        colorCollectionView.isPagingEnabled = true
        view.addSubview(colorCollectionView)
    }
}

    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ContentViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath)
        cell.backgroundColor = colorList[indexPath.row % colorList.count]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infiniteSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height + 7)
    }
}


