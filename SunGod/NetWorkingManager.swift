//
//  NetWorkingManager.swift
//  SunGod
//
//  Created by xiaolei on 16/5/29.
//  Copyright © 2016年 太阳在线. All rights reserved.
//
import SwiftyJSON
import Alamofire
import PKHUD
let baseURL = "http://119.29.3.138:8080/sunonlineAlpha1/webapi/videos/"

enum NetWorkingManager {
    
    case Videos
    case VideosKinds
    
    private func reuqestURL() -> String {
        switch self {
        case .Videos:
            return baseURL
        case .VideosKinds:
            return baseURL
        }
    }
    
    func requestData(success:(data:NSData?) -> Void) {
        switch self {
        case .Videos:
            request(.GET, reuqestURL())
                .validate()
                .responseJSON(completionHandler: { (res) in
                success(data:res.data)
            })
        case .VideosKinds:
            request(.GET, reuqestURL())
                .validate()
                .responseJSON(completionHandler: { (res) in
                success(data:res.data)
            })
            
        }
    }
}

/**
 判断网络的状态
 */
func listenNetWorking() -> Void {
    let net = NetworkReachabilityManager()
    net?.startListening()
    net?.listener = {
        state in
        switch state {
        case .Reachable(let net):
            //有网
            if net == .EthernetOrWiFi {
                HUD.show(HUDContentType.LabeledSuccess(title: "WiFi 网络", subtitle: "放心看"))
                HUD.hide(afterDelay: NSTimeInterval(1))
            }else {
                HUD.show(HUDContentType.LabeledSuccess(title: "你在使用WWAN网络", subtitle: "小心你的楼被电信运营商收走了"))
                HUD.hide(afterDelay: NSTimeInterval(1))
            }

        case .Unknown:
            HUD.show(HUDContentType.LabeledSuccess(title: "好厉害的网络", subtitle: "你用的什么网络呀"))
            HUD.hide(afterDelay: NSTimeInterval(1))
        case .NotReachable:
            //没有网络
            HUD.show(HUDContentType.LabeledError(title: "没有网络", subtitle: "亲,该交话费了"))
            HUD.hide(afterDelay: NSTimeInterval(1.5))
        }
    }
}



