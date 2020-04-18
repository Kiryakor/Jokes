//
//  ContentViewController.swift
//  Jokes
//
//  Created by Кирилл on 06.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit
import RealmSwift

class hrefList: Object {
    @objc dynamic var task = ""
}

class ContentViewController: UIViewController {
    
    //MARK: Var
    var contentCollectionView: UICollectionView!
    var loadIndicatorView:UIActivityIndicatorView!
    
    let realm = try! Realm() // Доступ к хранилищу
    var imageUrl: Results<hrefList>! //Контейнер со свойствами объекта TaskList
    var maxViewedIndex:Int = -1
    
    let server = Server()
    var dataList:[String] = []
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor()
        setup()
        
        //получаем данные из realm
        imageUrl = realm.objects(hrefList.self)
        var data:[String] = []
        for i in imageUrl{
            data.append(i.task)
        }
        if data.count != 0{
            loadIndicatorView.stopAnimating()
        }
        dataList += data
        print(dataList.count)
        if dataList.count < 10{
            loadData()
        }
        
        NotificationCenter.default.addObserver(self,selector: #selector(sceneWillResignActiveNotification(_:)),name: UIApplication.willResignActiveNotification,object: nil)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ContentViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == dataList.count - 4 { loadData() }
        maxViewedIndex = max(maxViewedIndex, indexPath.row)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReturn(cell: .contentCV), for: indexPath) as! ContentCVCell
        cell.contentCell(url: dataList[indexPath.row])
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

//MARK: func
extension ContentViewController{
    func loadData(){
        server.request { [weak self](data) in
            if data.count != 0{
                self?.loadIndicatorView.stopAnimating()
                self?.dataList += data
                self?.contentCollectionView.reloadData()
            }else{
                self?.alert()
            }
        }
    }
    
    func alert(){
        let alert = Alert.alertOneAction(titleAlert: nil,
                                         messageAlert: "Ошибка сервера".localized,
                                        preferredStyle: .alert,
                                        titleAction: "Повторить попытку".localized,
                                        styleAction: .default) { [weak self] (alert) in
                                            self?.loadData()
                                        }
        present(alert,animated:true)
    }
    
    @objc func sceneWillResignActiveNotification(_ notification: NSNotification){
        //удаляем все записи из realm
        try! self.realm.write {
            self.realm.delete(imageUrl)
        }
        
        var saveArray:[hrefList] = []
        for index in maxViewedIndex..<dataList.count{
            saveArray.append(hrefList(value: ["\(dataList[index])"]))
        }
        
        try! self.realm.write {
            self.realm.add(saveArray)
        }
    }
}

