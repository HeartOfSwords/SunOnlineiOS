//
//  VideoItemModel.swift
//  SunGod
//
//  Created by xiaolei on 16/5/11.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import SwiftyJSON

struct VideoItemModel {
    var videoTitle: String
    var videoImageURL: String
    var videoTime: String?
    var videoSeeNumber: Int
    var videoDescription: String
    
    init(videoTitle: String, videoImageURL: String, videoTime: String, videoSeeNumber: Int, videoDescription: String){
        self.videoTitle = videoTitle
        self.videoImageURL = videoImageURL
        self.videoTime = videoTime
        self.videoSeeNumber = videoSeeNumber
        self.videoDescription = videoDescription
    }
    /**
     通过获取服务器的数据来初始化一个 Video Model
     
     - parameter VideoData: Video Data
     
     - returns:
     */
    init(VideoData: AnyObject) {
        let videoJSONData = JSON(VideoData)
        videoTitle = videoJSONData[""].stringValue
        videoImageURL = videoJSONData[""].stringValue
        videoTime = videoJSONData[""].stringValue
        videoSeeNumber = videoJSONData[""].intValue
        videoDescription = videoJSONData[""].stringValue
    }
}
