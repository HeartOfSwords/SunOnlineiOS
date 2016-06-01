//
//  VideosListCollectionViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/11.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import MJRefresh
import NVActivityIndicatorView

private let reuseIdentifier = "videoListItem"
/// 屏幕的宽度
let mainScreen = UIScreen.mainScreen().bounds
/// 视频播放器的高度
let videoViewHeight = mainScreen.width * (9.0 / 16.0)

class VideosListCollectionViewController: UIViewController  {
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        setUpNavigation()
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
        ///collection View 布局
        collectionView.snp_makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalTo(view)
        }
        
        //添加下拉刷新
        collectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pullDownLoad))
        collectionView.mj_footer = MJRefreshBackStateFooter(refreshingTarget: self, refreshingAction: #selector(pullFooter))
        
    }
    
    func pullDownLoad() -> Void {
        collectionView.mj_header.endRefreshing()
    }
    
    func pullFooter() -> Void {
        collectionView.mj_footer.endRefreshingWithNoMoreData()
    }
    
    func setUpNavigation() {
        
        if self is VideosKingsListViewController {
            //如果是 VideosKingsListViewController 的话则不给他添加左上角的侧滑按钮
        }else {
            ///添加左上角的侧滑按钮
            addLeftBarButtonWithImage(UIImage(named: leftMenuImageName)!)
        }

        //设置返回按钮的文字为空
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationController?.hidesBarsOnSwipe = true
        title = "太阳在线"
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
    
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension VideosListCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        /**
         collection item 的大小
         
         - parameter width:  宽度为屏幕宽度
         - parameter height: 高度为屏幕的 9 ／16
         
         - returns: 返回size
         */
        return CGSize(width:view.frame.width, height: (view.frame.width) * (9.0 / 16))
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
}

// MARK: UICollectionViewDataSource
extension VideosListCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VideoCollectionViewCell
            cell.setUpCell(String(NSDate), information: "太原理工大学", photoURL: "http://7u2j0x.com1.z0.glb.clouddn.com/61b207a9jw1euys0v320ej20zk0bwwg7.jpg")
            return cell

    }
}

// MARK: UICollectionViewDelegate
extension VideosListCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        /// 选中 cell 之后进行跳转
        let videoItem = VideoItemInformationViewController()
            presentViewController(videoItem, animated: true) {
            
            }

    }
}

//MARK: -SlideMenuControllerDelegate
extension VideosListCollectionViewController: SlideMenuControllerDelegate {
    func leftWillOpen(){}
    func leftDidOpen(){}
    func leftWillClose(){}
    func leftDidClose(){}
}

