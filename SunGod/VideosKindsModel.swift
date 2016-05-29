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
    var URL: String
    var imageURL: String
    
    
    init(name: String, des: String, URL: String, imageURL: String){
        self.name = name
        self.des = des
        self.URL = URL
        self.imageURL = imageURL
    }
    
    /**
     通过获取服务器的数据来初始化
     
     - parameter VideoData: Video Data
     
     - returns:
     */
    init(VideoData: JSON) {
        let videoJSONData = VideoData
        name = videoJSONData["title"].stringValue
        des = videoJSONData["title"].stringValue
        URL = videoJSONData["title"].stringValue
        imageURL = videoJSONData["title"].stringValue
    }
    
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
