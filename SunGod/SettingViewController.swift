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

struct AboutUs {
    var name = ""
    var imageURL = ""
    var des = ""
    var itaDes = ""
}

class SettingViewController: UIViewController {

    let cellID = "AboutCollectionViewCell"
    var collectionView: UICollectionView!
    var sectionTitle = [String]()
    var sectioinItem = [String:[AboutUs]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftBarButtonWithImage(UIImage(named: leftMenuImageName)!)
        title = "设置"
        requestData()
//        print(sectionTitle)
    }

}
//MARK: Function
extension SettingViewController {
    
    func requestData() -> Void {
        let baseURL = "http://www.sunonline.vip:8080/sunonlineBeta1/"
        let data = NSData(contentsOfURL: NSURL(string: "http://www.sunonline.vip:8080/sunonlineBeta1/aboutUs.html")!)
        guard let daTa = data else {
            return
        }
        
        let jiDoc = Ji(htmlData: daTa)
        let titileNode = jiDoc?.xPath("//ol[@class='breadcrumb']/li[@class='active']")
        let titleImg = jiDoc?.xPath("//div[@class='title-img']/img")?.first
        let jumbotronDoc = jiDoc?.xPath("//div[@class='jumbotron']")?.first
        let sunStardoc = jiDoc?.xPath("//div[@class='container']")
        guard let sectionTitle = titileNode , titleimg = titleImg, jumbotrondoc = jumbotronDoc , sunStarDoc = sunStardoc else {
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
        
        var j = 1
        for i in sunStarDoc {
            print(j,"+++++++")
            j += 1
            let th = i.xPath("//div[@class='thumbnail']")
            for g in th {
                var star = AboutUs()
                let img = g.childrenWithName("img").first!
                star.imageURL = baseURL + img["src"]!
                let caption = img.nextSibling!.children
                let title = caption.first
                star.name = title!.content!
                let dec = title!.nextSibling!.content!
                star.des = dec
                
            }
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
        let nib = UINib(nibName: cellID, bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: cellID)
        
        view.addSubview(collectionView)
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension SettingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = mainScreen.size.width - 8 * 3
        return CGSize(width: width, height: width + 20)
    }
}
//MARK: UICollectionViewDataSource
extension SettingViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath)
        
        return cell
    }
}
