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
    
    /**
     通过获取服务器的数据来初始化
     
     - parameter VideoData: Video Data
     
     - returns:
     */
    init(VideoData: AnyObject) {
        let videoJSONData = JSON(VideoData)
        name = videoJSONData[""].stringValue
        des = videoJSONData[""].stringValue
        URL = videoJSONData[""].stringValue
        imageURL = videoJSONData[""].stringValue
    }
    
    static func videosKinds() -> [VideosKindsModel] {
        let videosKinds = [VideosKindsModel]()
        NetWorkingManager.VideosKinds.requestData { (data) in
            guard let data = data else {return}
            let jsonData = JSON(data)
            print(jsonData)
        }
        return videosKinds
    }
}
