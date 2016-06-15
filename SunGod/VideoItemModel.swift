//
//  VideoItemModel.swift
//  SunGod
//
//  Created by xiaolei on 16/5/11.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import SwiftyJSON
import RealmSwift

/// Realm 的单例
private class RealmData {
    static let share = RealmData()
    private init(){}
    ///初始化一个Realm时，仅需要在一个线程中之行一个这个初始化函数
    let realm = try! Realm()
}

class VideoItemModel: Object {
    dynamic var videoTitle: String = ""
    dynamic var videoImageURL: String = ""
    dynamic var videoTime: String = ""
    dynamic var videoID: String = ""
    dynamic var videoDescription: String = ""
    dynamic var videoURL: String = ""
    dynamic var videoPlayNumber: String = ""
    
    convenience  init(videoJSONData: JSON) {
        self.init()
        videoTitle = videoJSONData["videoName"].stringValue
        videoImageURL = videoJSONData["videoPicUrl"].stringValue
        videoTime = videoJSONData["videoDate"].stringValue
        videoPlayNumber = videoJSONData["videoPlayedNumber"].stringValue
        videoDescription = videoJSONData["videoIntro"].stringValue
        videoURL = videoJSONData["videoUrl"].stringValue
        videoID = videoJSONData["videoId"].stringValue
    }
    
    convenience  init(videoJSONData: CareVideoItem) {
        self.init()
        videoTitle = videoJSONData.videoTitle
        videoImageURL = videoJSONData.videoImageURL
        videoTime = videoJSONData.videoTime
        videoPlayNumber = videoJSONData.videoPlayNumber
        videoDescription = videoJSONData.videoDescription
        videoURL = videoJSONData.videoURL
        videoID = videoJSONData.videoID
    }
    
   override static func primaryKey() -> String? { return "videoID" }
    
    class func saveVideoItemModel(video:VideoItemModel,back:(res: Bool) -> Void) {
        let flag = false
        do {
            try RealmData.share.realm.write {
                RealmData.share.realm.add(video, update: true)
            }
            back(res: !flag)
        }catch {
            back(res: flag)
        }
        
    }
    
    class func deleteVideoItemModel(videoID: String, back:(res: Bool) -> Void) {
        let flag = false
        do {
            try RealmData.share.realm.write({
                let item = RealmData.share.realm.objects(VideoItemModel).filter(NSPredicate(format: "videoID = %@", videoID)).first
                RealmData.share.realm.delete(item!)
            })
            back(res: !flag)
        }catch {
            back(res: flag)
        }
    }
    
    class func selectVideoItemModel() -> [VideoItemModel] {
        var resData = [VideoItemModel]()
        let res = RealmData.share.realm.objects(VideoItemModel)
        res.forEach { (item) in
            resData.append(item)
        }
        return resData
    }
}
/// 关注的 视频
class CareVideoItem: VideoItemModel {
    
    convenience  init(videoJSONData: VideoItemModel) {
        self.init()
        videoTitle = videoJSONData.videoTitle
        videoImageURL = videoJSONData.videoImageURL
        videoTime = videoJSONData.videoTime
        videoPlayNumber = videoJSONData.videoPlayNumber
        videoDescription = videoJSONData.videoDescription
        videoURL = videoJSONData.videoURL
        videoID = videoJSONData.videoID
    }
    
    class func save(video:CareVideoItem,back:(res: Bool) -> Void) {
        let flag = false
        do {
            try RealmData.share.realm.write {
                RealmData.share.realm.add(video, update: true)
            }
            back(res: !flag)
        }catch {
            back(res: flag)
        }

    }
    
    class func delete(videoID: String, back:(res: Bool) -> Void) {
        let flag = false
        do {
            try RealmData.share.realm.write({
                let item = RealmData.share.realm.objects(CareVideoItem).filter(NSPredicate(format: "videoID = %@", videoID)).first
                RealmData.share.realm.delete(item!)
            })
            back(res: !flag)
        }catch {
            back(res: flag)
        }
    }
    
    class func select() -> [CareVideoItem] {
        var resData = [CareVideoItem]()
        let res = RealmData.share.realm.objects(CareVideoItem)
        res.forEach { (item) in
            resData.append(item)
        }
       return resData
    }
}
/// 下载的视频
class DownVideoItem: VideoItemModel {
    dynamic var homeURL: String = ""
}
