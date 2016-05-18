//
//  VideosListCollectionViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/11.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON
import SlideMenuControllerSwift
import SnapKit

private let reuseIdentifier = "videoListItem"
/// 屏幕的宽度
let mainScreen = UIScreen.mainScreen().bounds
/// 视频播放器的高度
let videoViewHeight = mainScreen.width * (9.0 / 16.0)

class VideosListCollectionViewController: UIViewController  {
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSHomeDirectory())
        setUpCollectionView()

        
    }

}


// MARK: extension
extension VideosListCollectionViewController {
    
    func setUpCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        let cellNib = UINib(nibName: "VideoCollectionViewCell", bundle: nil)
        collectionView.registerNib(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        
        view.addSubview(collectionView)
        collectionView.snp_makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalTo(view)
        }
    }
    
    func setUpNavigation() {
        //添加左上角的侧滑按钮
        addLeftBarButtonWithImage(UIImage(named: "ic_view_headline_36pt")!)
    }
    
    /**
     计算label 文字的高度
     
     - parameter font:  文字所使用的字体
     - parameter width: label 的宽度
     
     - returns: 计算出来的高度
     */
    
    func heightForComment(font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string:"这里是视频的描述，我是视频的描述。太原理工大学，太阳在线，Swift，iOS").boundingRectWithSize(CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil)
        return ceil(rect.height)
    }
    
    
    func upYunConfig() {
        
        /*
         curl http://v0.api.upyun.com/<bucket-name> \
         -F file=@<filename> \
         -F policy=<policy> \
         -F signature=<signature>
         */
        let url = "http://v0.api.upyun.com/"
        let bucket = "sunonlinevideos"
        
        
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension VideosListCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: mainScreen.width, height: videoViewHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
    }
}

// MARK: UICollectionViewDataSource
extension VideosListCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VideoCollectionViewCell
            cell.photo.kf_setImageWithURL(NSURL(string: "http://7u2j0x.com1.z0.glb.clouddn.com/61b207a9jw1euys0v320ej20zk0bwwg7.jpg")!)
            cell.time.text = String(NSDate())
            cell.information.text = "这里是视频的描述，我是视频的描述。太原理工大学，太阳在线，Swift，iOS"
            return cell

    }
}

// MARK: UICollectionViewDelegate
extension VideosListCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let videoItem = VideoItemInformationViewController()
        navigationController?.pushViewController(videoItem, animated: true)

    }
    
    
//    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }

}

//MARK: -SlideMenuControllerDelegate
extension VideosListCollectionViewController: SlideMenuControllerDelegate {
    func leftWillOpen(){}
    func leftDidOpen(){}
    func leftWillClose(){}
    func leftDidClose(){}
}

