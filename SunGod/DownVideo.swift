//
//  DownVideo.swift
//  SunGod
//
//  Created by xiaolei on 16/6/6.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import Foundation
import Alamofire
class DownVideo {
    
    static func down(Dataurl:String,back:(down:NSURL)->Void) {
        Alamofire.download(.GET, Dataurl) { (url, res) -> NSURL in
            let fileManger = NSFileManager.defaultManager()
            let document = fileManger.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
            let doc = document.URLByAppendingPathComponent("com.taiyangzx.videos",isDirectory: true)
            try! fileManger.createDirectoryAtURL(doc, withIntermediateDirectories: true, attributes: nil)
            let down = doc.URLByAppendingPathComponent("text.mp4")
            return down
           
        }
            .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
                let percent = totalBytesRead * 100 / totalBytesExpectedToRead
                print("已经下载 : \(totalBytesRead) 当前进度 \(percent) %")
        }
    }
}