//
//  ContentViewController.swift
//  Jokes
//
//  Created by Кирилл on 06.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ContentViewController: UIViewController,ContentCollectionView {
    
    //MARK: Var
    var contentCollectionView: UICollectionView!
    private var loadIndicatorView:UIActivityIndicatorView!
    private var interstitial: GADInterstitial!
    
    private var maxViewedIndex:Int = 0
    private var activeIndex:Int = 0
    private var urlList:[String] = []
    private var dataList:[Data] = []

    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = createAndLoadInterstitial()
        
        view.backgroundColor = .backgroundColor()
        setup()
        loadPathImageRealm()
        
        NotificationCenter.default.addObserver(self,selector: #selector(sceneWillResignActiveNotification(_:)),name: UIApplication.willResignActiveNotification,object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sceneWillResignLongTapImage(_:)), name: NSNotification.Name(rawValue: notificationNameReturn(name: .longTapImageScrollView)), object: nil)
    }
    
    @objc func sceneWillResignActiveNotification(_ notification: NSNotification){
        RealmHelpers.saveData(data: urlList, startIndex: maxViewedIndex)
        UserLocalNotifications.sendNotification()
    }
    
    @objc func sceneWillResignLongTapImage(_ notification: NSNotification){
        Server.loadImage(url: urlList[activeIndex]) { (data) in
            Sharing.share(on: self, text: "Infinity meme", image: UIImage(data: data), link: nil)
        }
    }
    

    private func cellHelpers(index:Int){
        maxViewedIndex = max(maxViewedIndex, index)
        activeIndex = index
        
        if index == urlList.count - 15 { loadPathImageServer() }
        if index == 15 { RateManager.showRateController() }
        if index == dataList.count - 10 { loadDataImage() }
        if index % 20 == 19 && interstitial.isReady { interstitial.present(fromRootViewController: self) }
        if index + 2 == dataList.count && !Connectivity.isConnectedToInternet(){ Alert.errorInternetAlert(on: self) }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ContentViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReturn(cell: .contentCV), for: indexPath) as! ContentCVCell
        cellHelpers(index: indexPath.row)
        cell.setImage(image: UIImage(data: dataList[indexPath.row])!)
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
    private func setup(){
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

//MARK: LoadDataProtocol
extension ContentViewController: LoadDataProtocol{
    func loadPathImageRealm() {
        urlList += RealmHelpers.loadDataAndStringConvert()
        
        if dataList.count > 0{
            loadIndicatorView.stopAnimating()
            loadDataImage()
        }
        
        if dataList.count < 20{
            loadPathImageServer()
        }
    }
    
    func loadPathImageServer() {
        Server.request { [weak self](data) in
            if data.count != 0{
                self?.urlList += data
                self?.loadDataImage()
            }else{
                Alert.errorServerAlert(on: self!)
            }
        }
    }

    func loadDataImage(){
        let index = maxViewedIndex
        let minValue = min(25, urlList.count - maxViewedIndex)
        let imageGroup = DispatchGroup()
        for i in 0..<minValue{
            imageGroup.enter()
            Server.loadImage(url: self.urlList[index+i]) { [weak self] (data) in
                self?.dataList.append(data)
                imageGroup.leave()
            }
        }
        
        imageGroup.notify(queue: .main) {
            self.loadIndicatorView.stopAnimating()
            self.contentCollectionView.reloadData()
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
