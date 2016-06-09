//
//  VideosKindsModel.swift
//  SunGod
//
//  Created by xiaolei on 16/5/29.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import SwiftyJSON

struct VideosKindsModel {
    
    var name: String
    var des: String
    var allVideosURL: String
    var imageURL: String
    
    /**
     通过值来进行初始化一个栏目
     
     - parameter name:     name
     - parameter des:      des
     - parameter URL:      URL
     - parameter imageURL: imageURL
     
     - returns: VideosKindsModel
     */
    init(name: String, des: String, URL: String, imageURL: String){
        self.name = name
        self.des = des
        self.allVideosURL = URL
        self.imageURL = imageURL
    }
    
    /**
     通过获取服务器的数据来初始化
     
     - parameter VideoData: Video Data
     
     - returns: VideosKindsModel
     */
    init(VideoData: JSON) {
        
        name = VideoData["title"].stringValue
        des = VideoData["introduceMessage"].stringValue
        allVideosURL = baseURL + VideoData["href"].stringValue
        imageURL = VideoData["priUrl"].stringValue
    }
    /**
     通过网络获取数据来生成一个 VideosKindsModel 数组
     
     - parameter success: success 返回闭包，如果获取不成功的话将会返回一个空的数组
     */
    static func videosKinds(success:(videoskinds:[VideosKindsModel]) -> Void) {
        var videosKinds = [VideosKindsModel]()
        NetWorkingManager.VideosKinds.requestData { (data) in
            guard let data = data else {print("Error");return}
            let jsonData = JSON(data)["links"]
            for (_, subJSON) in jsonData {
                let kind = VideosKindsModel(VideoData:subJSON)
                videosKinds.append(kind)
            }
            success(videoskinds: videosKinds)
        }
    }
}
