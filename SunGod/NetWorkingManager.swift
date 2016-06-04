//
//  NetWorkingManager.swift
//  SunGod
//
//  Created by xiaolei on 16/5/29.
//  Copyright © 2016年 太阳在线. All rights reserved.
//
import SwiftyJSON
import Alamofire

let baseURL = "http://119.29.3.138:8080/sunonlineAlpha1/webapi/videos/"

enum NetWorkingManager {
    
    case Videos
    case VideosKinds
    
    private func reuqestURL() -> String {
        switch self {
        case .Videos:
            return baseURL + ""
        case .VideosKinds:
            return baseURL
        }
    }
    
    func requestData(success:(data:NSData?) -> Void) {
        switch self {
        case .Videos:
            request(.GET, reuqestURL()).responseJSON(completionHandler: { (res) in
                success(data:res.data)
            })
        case .VideosKinds:
            request(.GET, reuqestURL()).responseJSON(completionHandler: { (res) in
                success(data:res.data)
            })
            
        }
    }
}


