//
//  SettingViewController.swift
//  SunGod
//
//  Created by 太阳在线 on 16/5/23.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import SnapKit
import Ji
import Kingfisher
import MJRefresh
import Haneke
import Alamofire


struct AboutUs {
    var name = ""
    var imageURL = ""
    var des = ""
    var itaDes = ""
    var videoURL = ""
}

class SettingViewController: UIViewController {

    let cellID = "AboutCollectionViewCell"
    var collectionView: UICollectionView!
    var sectionTitle = [String]()
    var sectioinItem = [String:[AboutUs]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftBarButtonWithImage(UIImage(named: leftMenuImageName)!)
        title = "关于我们"
        setUpCollection()
        requestCache()
    }

}
//MARK: Function
extension SettingViewController {
    
    
    func requestCache() -> Void {
        let cache = Shared.dataCache
        cache.remove(key: "aboutUs")
        cache.fetch(key: "aboutUs").onFailure { (error) in
            
            Alamofire.request(.GET, "http://www.sunonline.vip:8080/sunonlineBeta1/aboutUs.html").responseData { (res) in
                self.requestData(res.data)
            }
        }
        .onSuccess { (data) in
            self.requestData(data)
        }
    }
    
    func requestData(data:NSData?) -> Void {
        
        let baseURL = "http://www.sunonline.vip:8080/sunonlineBeta1/"
        let cache = Shared.dataCache
        guard let daTa = data else {
            print("error")
            collectionView.mj_header.endRefreshing()
            return
        }
        
        let jiDoc = Ji(htmlData: daTa)
        let titileNode = jiDoc?.xPath("//ol[@class='breadcrumb']/li[@class='active']")
        let titleImg = jiDoc?.xPath("//div[@class='title-img']/img")?.first
        let jumbotronDoc = jiDoc?.xPath("//div[@class='jumbotron']")?.first
        let sunStardoc = jiDoc?.xPath("//div[@class='container']")
        let videoURl = jiDoc?.xPath("//div[@class='container']//a")
        
        guard let sectionTitle = titileNode , titleimg = titleImg, jumbotrondoc = jumbotronDoc , sunStarDoc = sunStardoc,videoURL = videoURl else {
            collectionView.mj_header.endRefreshing()
            return
        }
        // section
        for i in sectionTitle {
            self.sectionTitle.append(i.content!)
        }
        
        
        let titleImgURl = baseURL + titleimg["src"]!
        var jumbotron = AboutUs()
        jumbotron.imageURL = titleImgURl
        let jumbotronTitle = jumbotrondoc.firstChild!.content!
        jumbotron.name = jumbotronTitle
        let jumbotronDes = jumbotrondoc.childrenWithName("p").first?.content
        jumbotron.des = jumbotronDes!
        let jumbotronItaDes = jumbotrondoc.childrenWithName("div").first?.childrenWithName("p")
        for i in jumbotronItaDes! {
            jumbotron.itaDes += i.content!
        }
        sectioinItem[self.sectionTitle[0]] = [jumbotron]
        
        var num = 1
        for i in sunStarDoc {

            let thumbnail = i.xPath("div//div[@class='thumbnail']")
            var itemArray = [AboutUs]()
            for g in thumbnail {
                
                
                let img = g.childrenWithName("img").first
                guard let imgA = img else {
                    return
                }
                var star = AboutUs()
                star.imageURL = baseURL + imgA["src"]!
                let caption = imgA.nextSibling!.children
                let title = caption.first
                star.name = title!.content!
                let dec = title!.nextSibling?.rawContent
                
                star.des = dec!
                itemArray.append(star)
                
            }
            if itemArray.count > 0  {
                sectioinItem[self.sectionTitle[num]] = itemArray
                num += 1
            }
        }
        
        //双创作品URL
        var j = 0
        for i in videoURL {
            
            let href = i["href"]!
            
            if href.hasPrefix("http://") {
                let title = self.sectionTitle.last!
                sectioinItem[title]![j].videoURL = href
                j += 1
            }
        }
        
        collectionView.mj_header.endRefreshing()
        collectionView.reloadData()
//        waitView.stopAnimation()
        cache.set(value: daTa, key: "aboutUs")
    }
    
    func pullDown() {
        sectionTitle = []
        sectioinItem = [:]
        Alamofire.request(.GET, "http://www.sunonline.vip:8080/sunonlineBeta1/aboutUs.html").responseData { (res) in
            self.requestData(res.data)
        }
    }
}

//MARK: UICollectionViewDelegate
extension SettingViewController: UICollectionViewDelegate {
    func setUpCollection() -> Void {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        let nib = UINib(nibName: cellID, bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: cellID)
        let headNib = UINib(nibName: "HeaderCollectionReusableView", bundle: nil)
        collectionView.registerNib(headNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "FlickrPhotoHeaderView")
        view.addSubview(collectionView)
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        let collectionHeadView = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pullDown))
        collectionHeadView.lastUpdatedTimeLabel.hidden = true
        collectionHeadView.setTitle("下拉刷新", forState: MJRefreshState.Idle)
        collectionHeadView.setTitle("松开立刻刷新", forState: MJRefreshState.Pulling)
        collectionHeadView.setTitle("正在刷新", forState: MJRefreshState.Refreshing)
        collectionView.mj_header = collectionHeadView
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
        let title = sectionTitle[section]
        let items = sectioinItem[title]![indexPath.item]
        let cv =  AboutMoreViewController()
        cv.aboutUs = items
        self.navigationController?.pushViewController(cv, animated: true)
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension SettingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let section = indexPath.section
        if section == 0 {
            let width = mainScreen.size.width
            return CGSize(width: width, height: width * (9 / 16) )
        }else if section == 1 {
            let width = mainScreen.size.width
            return CGSize(width: width * 0.8 , height: width * 0.8)
        }else if section == sectionTitle.count - 1 {
            let width = mainScreen.size.width
            return CGSize(width: width * 0.8, height: width * 0.8 )
        }
        else {
            let width = mainScreen.size.width - 2
            return CGSize(width: width / 2, height: width / 2 + 20)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = mainScreen.size.width
        return CGSize(width: width, height: 50)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let ed = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        return ed
    }
}
//MARK: UICollectionViewDataSource
extension SettingViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return sectionTitle.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let titlee = sectionTitle[section]
        let number = sectioinItem[titlee]!.count
        return number
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! AboutCollectionViewCell
        let section = indexPath.section
        let title = sectionTitle[section]
        let item = sectioinItem[title]![indexPath.item]
        cell.name.text = item.name
        cell.photo.kf_setImageWithURL(NSURL(string: item.imageURL)!)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "FlickrPhotoHeaderView", forIndexPath: indexPath) as! HeaderCollectionReusableView
            
            headerView.title.text = sectionTitle[indexPath.section]
            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }
}
