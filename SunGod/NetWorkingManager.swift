//
//  NetWorkingManager.swift
//  SunGod
//
//  Created by xiaolei on 16/5/29.
//  Copyright © 2016年 太阳在线. All rights reserved.
//
import SwiftyJSON

enum NetWorkingManager {
    
    case Videos
    case VideosKinds
    
    private var baseURL: String { return "http://119.29.3.138:8080/SunOnline/" }
    
    private func reuqestURL() -> String {
        switch self {
        case .Videos:
            return baseURL + "webapi"
        case .VideosKinds:
            return baseURL + "webapi"
        }
    }
    
    func requestData(success:(data:AnyObject?) -> Void) {
        switch self {
        case .Videos:
            HYBNetworking.getWithUrl(reuqestURL(), refreshCache: true, success: { (data) in
                success(data: data)
            }) { (error) in
                success(data: nil)
            }

        case .VideosKinds:
            HYBNetworking.getWithUrl(reuqestURL(), refreshCache: true, success: { (data) in
                success(data: data)
            }) { (error) in
                success(data: nil)
            }
        }
    }
}


