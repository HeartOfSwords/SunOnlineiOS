//
//  QiNiuManager.swift
//  SunGod
//
//  Created by xiaolei on 16/5/29.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import Qiniu
import SwiftyJSON

class QiNiuManager {
    
    private let kQiniuBucket = "yangxiaolei"
    private let kQiniuAccessKey = "8jg3EmivN_pfmy-lRs_RPRhKPNPinuJ2PgbfJUUY"
    private let kQiniuSecretKey = "_C0SXewPsWtVdECch9snbhzHVIzhLu9nMMrB-Fcj"
    
    private let baseURL = "http://7s1rp2.com1.z0.glb.clouddn.com"
    //七牛 上传管理
    private let upManager = QNUploadManager()

    private init() {}
    //构造一个单例
    static let sharedQiNiu = QiNiuManager()
    
    //客户端生成 put token
    //http://blog.lessfun.com/blog/2015/12/29/swift-create-qiniu-upload-token/
    // 辅助方法
    private func hmacsha1WithString(str: String, secretKey: String) -> NSData {
        
        let cKey  = secretKey.cStringUsingEncoding(NSASCIIStringEncoding)
        let cData = str.cStringUsingEncoding(NSASCIIStringEncoding)
        //CCHmac 使用的是 Objective C 的 #import <CommonCrypto/CommonCrypto.h>
        var result = [CUnsignedChar](count: Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), cKey!, Int(strlen(cKey!)), cData!, Int(strlen(cData!)), &result)
        let hmacData: NSData = NSData(bytes: result, length: (Int(CC_SHA1_DIGEST_LENGTH)))
        return hmacData
    }
    
    /**
     生成 Put Token
     
     - parameter fileName: 文件要上传的子目录
     
     - returns: 生成的TOKEN
     */
    private func createQiniuPutToken(fileName: String) -> String {
        
        let oneHourLater = NSDate().timeIntervalSince1970 + 3600
        // 上传策略中，只有scope和deadline是必填的
        let scope = fileName.isEmpty ? kQiniuBucket : kQiniuBucket + ":" + fileName;
        let putPolicy: JSON = ["scope": scope, "deadline": NSNumber(unsignedLongLong: UInt64(oneHourLater))]
        let jsonPutPolicy = putPolicy.description
        let encodedPutPolicy = QNUrlSafeBase64.encodeString(jsonPutPolicy)
        let sign = hmacsha1WithString(encodedPutPolicy, secretKey: kQiniuSecretKey)
        let encodedSign = QNUrlSafeBase64.encodeData(sign)
        
        return kQiniuAccessKey + ":" + encodedSign + ":" + encodedPutPolicy
    }
    /**
     生成 DownLoad Token
     
     - returns: DownloadToken
     */
    private func createQiniuDownloadToken() -> String {
        let e = NSDate().timeIntervalSince1970.description
        print(e)
        let downURL = baseURL + "?e=" + e
        let sign = hmacsha1WithString(downURL, secretKey: kQiniuSecretKey)
        let encodedSign = QNUrlSafeBase64.encodeData(sign)
        return kQiniuAccessKey + ":" + encodedSign
    }

}


extension QiNiuManager {
    //上传示例
    func uploadWithName() {
        createQiniuDownloadToken()
        let token = createQiniuPutToken("")
        let filePath = NSBundle.mainBundle().pathForResource("HTML", ofType: "mp4")
        print(filePath)
        upManager
        upManager.putFile(filePath, key: "name5", token: token, complete: { (info, key, resp) in
            print(info)
            }, option: nil)
    }
}