//
//  VideosKindsViewController.swift
//  SunGod
//
//  Created by 太阳在线 on 16/5/23.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import SnapKit


class VideosKindsViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let kindsCellidentifier = "kindsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpNav()
        setUpCollectionView()
    }


}

extension VideosKindsViewController {
    func setUpView() {
        title = "栏目"
    }
    
    func setUpNav() {
        ///添加左上角的侧滑按钮
        addLeftBarButtonWithImage(UIImage(named: "ic_view_headline_36pt")!)
    }
    
    func setUpCollectionView() -> Void {
        let layout = UICollectionViewFlowLayout()
        let width = (mainScreen.width - 2) / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        let cellNib = UINib(nibName: "VideoKindsCollectionViewCell", bundle: nil)
        collectionView.registerNib(cellNib, forCellWithReuseIdentifier: kindsCellidentifier)
        collectionView.backgroundColor = UIColor.whiteColor()
        view.addSubview(collectionView)
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
    }
}


extension VideosKindsViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cv = VideosListCollectionViewController()
        navigationController?.pushViewController(cv, animated: true)
    }

}

extension VideosKindsViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kindsCellidentifier, forIndexPath: indexPath) as! VideoKindsCollectionViewCell
        cell.setUpCell("yangxiaolei", photoURL: "http://7u2j0x.com1.z0.glb.clouddn.com/61b207a9jw1euys0v320ej20zk0bwwg7.jpg")
        return cell
    }
}
