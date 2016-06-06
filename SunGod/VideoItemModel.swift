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
    var videoTime: String
    var videoID: String
    var videoDescription: String
    var videoURL: String
    var videoPlayNumber: String
    /**
     通过值来进行初始化
     
     - parameter videoTitle:       videoTitle
     - parameter videoImageURL:    videoImageURL
     - parameter videoTime:        videoTime
     - parameter videoSeeNumber:   videoSeeNumber
     - parameter videoDescription: videoDescription
     
     - returns: VideoItemModel
     */
    init(videoTitle: String,
         videoImageURL: String,
         videoTime: String,
         videoID: String,
         videoDescription: String,
         videoURL: String,
         videoPlayNumber: String){
        self.videoTitle = videoTitle
        self.videoImageURL = videoImageURL
        self.videoTime = videoTime
        self.videoID = videoID
        self.videoDescription = videoDescription
        self.videoURL = videoURL
        self.videoPlayNumber = videoPlayNumber
    }
    /**
     通过获取服务器的数据来初始化一个 Video Model
     
     - parameter VideoData: Video Data
     
     - returns:
     */
    init(videoJSONData: JSON) {
        videoTitle = videoJSONData["higoVideoName"].stringValue
        videoImageURL = videoJSONData["higoVideoPicUrl"].stringValue
        videoTime = videoJSONData["higoVideoDate"].stringValue
        videoPlayNumber = videoJSONData["higoVideoPlayedNumber"].stringValue
        videoDescription = videoJSONData["higoVideoIntro"].stringValue
        videoURL = videoJSONData["higoVideoUrl"].stringValue
        videoID = videoJSONData["higoVideoId"].stringValue
    }
}
