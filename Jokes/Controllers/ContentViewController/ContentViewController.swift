//
//  ContentViewController.swift
//  Jokes
//
//  Created by Кирилл on 06.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ContentViewController: UIViewController {
    
    //MARK: Var
    var contentCollectionView: UICollectionView!
    var loadIndicatorView:UIActivityIndicatorView!
    var interstitial: GADInterstitial!
    
    var maxViewedIndex:Int = 0
    var activeIndex:Int = 0
    var dataList:[String] = []
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = createAndLoadInterstitial()
        
        view.backgroundColor = .backgroundColor()
        setup()
        loadDataRealm()
        
        NotificationCenter.default.addObserver(self,selector: #selector(sceneWillResignActiveNotification(_:)),name: UIApplication.willResignActiveNotification,object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sceneWillResignLongTapImage(_:)), name: NSNotification.Name(rawValue: "longTapImageScrollView"), object: nil)
    }
    
    @objc func sceneWillResignActiveNotification(_ notification: NSNotification){
        RealmHelpers.saveData(data: dataList, startIndex: maxViewedIndex)
    }
    
    @objc func sceneWillResignLongTapImage(_ notification: NSNotification){
        Server.loadImage(url: dataList[activeIndex]) { (data) in
            Sharing.share(on: self, text: "Infinity meme", image: UIImage(data: data), link: nil)
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ContentViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == dataList.count - 4 { loadDataServer() }
        if indexPath.row == 15 { RateManager.showRateController() }
        maxViewedIndex = max(maxViewedIndex, indexPath.row)
        activeIndex = indexPath.row
        
        if interstitial.isReady && indexPath.row % 10 == 9 {
            interstitial.present(fromRootViewController: self)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReturn(cell: .contentCV), for: indexPath) as! ContentCVCell
        Connectivity.isConnectedToInternet() ? cell.contentCell(url: dataList[indexPath.row]) : Alert.errorInternetAlert(on: self)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

//MARK: Setup
extension ContentViewController{
    func setup(){
        //CollectionView
        let flowLayout = UICollectionViewFlowLayout(scrollDirection: .horizontal, minimumLineSpacing: 0)
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        contentCollectionView = UICollectionView(frame: frame,flowLayout: flowLayout, isPagingEnabled: true)
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.showsHorizontalScrollIndicator = false
        contentCollectionView.register(ContentCVCell.self, forCellWithReuseIdentifier: cellReturn(cell: .contentCV))
        view.addSubview(contentCollectionView)
        
        //ActivityIndicatorView
        loadIndicatorView = UIActivityIndicatorView()
        loadIndicatorView.startAnimating()
        view.addSubview(loadIndicatorView)
        loadIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        loadIndicatorView.color = .blackColor()
        NSLayoutConstraint.activate([
            loadIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

//MARK: loadData
extension ContentViewController{
    func loadDataServer(){
        Server.request { [weak self](data) in
            if data.count != 0{
                self?.loadIndicatorView.stopAnimating()
                self?.dataList += data
                self?.contentCollectionView.reloadData()
            }else{
                Alert.errorServerAlert(on: self!)
            }
        }
    }
    
    func loadDataRealm(){
        dataList += RealmHelpers.loadDataAndStringConvert()
        
        if dataList.count > 0{
            loadIndicatorView.stopAnimating()
            contentCollectionView.reloadData()
        }
        
        if dataList.count < 10{
            loadDataServer()
        }
    }
}

//MARK: GoogleMobileAds
extension ContentViewController: GADInterstitialDelegate{
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: adUnitIDReturn(cell: .contentInterstitial))
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }

    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      interstitial = createAndLoadInterstitial()
    }
}
