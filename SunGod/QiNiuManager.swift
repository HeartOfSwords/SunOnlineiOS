//
//  QiNiuManager.swift
//  SunGod
//
//  Created by xiaolei on 16/5/29.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import Qiniu

class QiNiuManager {
    
    private let token = "_C0SXewPsWtVdECch9snbhzHVIzhLu9nMMrB-Fcj"
    let upManager = QNUploadManager()
//    let data = NSData(
    private init() {}
    static let sharedQiNiu = QiNiuManager()
}