//
//  SLPictureBrowsingViewController.swift
//  SwiftStudy
//
//  Created by wsl on 2019/6/24.
//  Copyright © 2019 wsl. All rights reserved.
//

import UIKit
import Kingfisher
//图集浏览控制器
class SLPictureBrowsingViewController: UIViewController {
    
    lazy var collectionView : UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal;
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(SLPictureBrowsingCell.self, forCellWithReuseIdentifier: "ImageCellId")
        return collectionView
    }()
    var imagesArray:[String] = []
    
    // MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        ImageCache.default.clearMemoryCache()
//        ImageCache.default.clearDiskCache {
//            print("图片清除缓存完毕")
//        }
    }
   // MARK: UI
    func setupUI() {
        self.navigationItem.title = "图集浏览"
        self.view.backgroundColor = UIColor.white;
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}
   // MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension SLPictureBrowsingViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:SLPictureBrowsingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCellId", for: indexPath) as! SLPictureBrowsingCell;
        cell.reloadData(picUrl: self.imagesArray[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

