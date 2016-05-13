//
//  VideosListCollectionViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/11.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import SDCycleScrollView
import SDWebImage

private let reuseIdentifier = "videoListItem"
private let mainScreen = UIScreen.mainScreen().bounds
private let sdCycleScrollViewHeight = mainScreen.width * (9.0 / 16.0)

class VideosListCollectionViewController: UIViewController  {
    
    private var collectionView: UICollectionView!
    
    weak var contantView: PageMenuViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        let cellNib = UINib(nibName: "VideoCollectionViewCell", bundle: nil)
        collectionView.registerNib(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "SDCycelScroll")
        view.addSubview(collectionView)
        collectionView.snp_makeConstraints { (make) in
            make.leading.top.trailing.equalTo(view)
            make.bottom.equalTo(view.snp_bottom).offset(-106)
        }
    }
}


// MARK: extension
extension VideosListCollectionViewController {
    func heightForComment(font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string:"这里是视频的描述，我是视频的描述。太原理工大学，太阳在线，Swift，iOS").boundingRectWithSize(CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil)
        return ceil(rect.height)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension VideosListCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        /// 每个Cell的宽度为设备的宽度，高度为宽度的 9/16。这个高度不包括对视频的描述的文字高度 仅仅是视频图片的高度 最终的高度是图片的高度加上视频描述的文字的高度
        
        let width = mainScreen.width
        let height = width * (9.0/16.0)
        
        switch indexPath.section {
        case 0:
            ///section 为0的cell 用来放轮播图
            return CGSize(width: width, height: height)
        default:
            let commentHeight = heightForComment(UIFont.systemFontOfSize(22), width: mainScreen.width)
            return CGSize(width: width, height: height + commentHeight)
        }
      
       
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsetsZero
        default:
            return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
        
    }
}

// MARK: UICollectionViewDataSource
extension VideosListCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        default:
            return 10
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            
        case 0:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SDCycelScroll", forIndexPath: indexPath)
            //将轮播图插入到 内容视图中。
            let urls = ["http://7u2j0x.com1.z0.glb.clouddn.com/61b207a9jw1euys0v320ej20zk0bwwg7.jpg","http://7u2j0x.com1.z0.glb.clouddn.com/61b207a9jw1euys0v320ej20zk0bwwg7.jpg","http://7u2j0x.com1.z0.glb.clouddn.com/61b207a9jw1euys0v320ej20zk0bwwg7.jpg"]
            //初始化一个轮播图控件
            
            let imageScrollView = SDCycleScrollView(frame: CGRectMake(0, 0, mainScreen.width, CGFloat(sdCycleScrollViewHeight)))
            imageScrollView.delegate = self
            imageScrollView.imageURLStringsGroup = urls
            imageScrollView.titlesGroup = ["太阳在线","我是杨晓磊", "杨晓磊是个大帅逼"]
            imageScrollView.autoScrollTimeInterval = CGFloat(5.0)
            cell.contentView.addSubview(imageScrollView)
            return cell
            
        default:
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VideoCollectionViewCell
            
            cell.photo.sd_setImageWithURL(NSURL(string: "http://7u2j0x.com1.z0.glb.clouddn.com/61b207a9jw1euys0v320ej20zk0bwwg7.jpg")!)
            cell.time.text = String(NSDate())
            cell.information.text = "这里是视频的描述，我是视频的描述。太原理工大学，太阳在线，Swift，iOS"
            return cell
        }

    }
}

// MARK: UICollectionViewDelegate
extension VideosListCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let videoItem = VideoItemInformationViewController()
        contantView.presentViewController(videoItem, animated: true) { 
            //跳转之后
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

}

// MARK: SDCycleScrollViewDelegate
extension VideosListCollectionViewController: SDCycleScrollViewDelegate {
    /** 点击图片回调 */
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
        let videoItem = VideoItemInformationViewController()
        
        contantView.presentViewController(videoItem, animated: true) { 
            //跳转之后
        }
    }
    
    /** 图片滚动回调 */
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didScrollToIndex index: Int) {
        
    }
}
