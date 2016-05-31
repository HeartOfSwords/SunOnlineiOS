//
//  WilddogManager.swift
//  GithubStar
//
//  Created by xiaolei on 16/3/29.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Wilddog

struct WilddogManager {
    
    static let ref = Wilddog(url: "https://sungod.wilddogio.com")
    
    static func wilddogLogin() {
        //监听用户的登陆状况
        ref.observeAuthEventWithBlock { (authData) in
            if authData != nil {
                //用户已经认证
                
            }else {
                //用户没有认证，进行匿名登陆
                WilddogManager.ref.authAnonymouslyWithCompletionBlock({ (error, autherData) in
                    if error == nil {
                        //登陆成功
                        print(autherData.uid)
                    }else {
                        //登陆失败
                    }
                })
                
            }
        }
    }
}


struct WilddogCommiteModel {
    var autherName = ""
    var autherID = ""
    var commiteTime = ""
    var commiteValue = ""
    var autherImageURL = ""
}



