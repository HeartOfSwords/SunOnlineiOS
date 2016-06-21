//
//  AboutMoreViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/6/17.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
class AboutMoreViewController: UIViewController {

    var aboutUs: AboutUs!
    let image = UIImageView()
    let text = UITextView()
    let name = UILabel()
    var videoURl:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        videoURl = aboutUs.videoURL
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(image)
        view.addSubview(text)
        view.addSubview(name)
        
        image.kf_setImageWithURL(NSURL(string: aboutUs.imageURL)!)
        name.text = aboutUs.name
        name.textAlignment = .Center
        name.font = UIFont.boldSystemFontOfSize(18)
        name.numberOfLines = 0
        let value = NSString(string: aboutUs.des + aboutUs.itaDes)
        let attributedString = try? NSAttributedString(data: value.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        text.attributedText = attributedString
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFontOfSize(16)
        text.editable = false
        image.snp_makeConstraints { (make) in
            make.height.width.equalTo(mainScreen.width * 0.8)
            make.top.equalTo(self.view).offset(8)
            make.leading.equalTo(mainScreen.width * 0.1)
        }
        
        name.snp_makeConstraints { (make) in
            make.width.equalTo(image.snp_width)
            make.top.equalTo(image.snp_bottom).offset(3)
            make.leading.equalTo(image.snp_leading)
        }
        
        text.snp_makeConstraints { (make) in
            make.leading.equalTo(0)
            make.bottom.trailing.equalTo(0)
            make.top.equalTo(name.snp_bottom).offset(3)
        }
        
        if videoURl.hasPrefix("http") {
            let tap = UITapGestureRecognizer(target: self, action: #selector(playVideo))
            image.addGestureRecognizer(tap)
            image.userInteractionEnabled = true
        }
    }
    
    func playVideo() {
        let url = aboutUs.videoURL
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        
    }


}
