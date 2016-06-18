//
//  ComiteViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/6/13.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import SwiftyJSON

class ComiteViewController: JSQMessagesViewController {
    
    var videoIDAndVideoName: String!
    var messages = [JSQMessage]()
    
    let user = UserModel()
    
    //收到消息的背景颜色
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    //发出消息的背景颜色
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.id = "1234"
        user.name = "这块显卡有点冷"
        setUpSendUser()
        setUpWilldog()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 32))
        button.setTitle("X", forState: .Normal)
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        inputToolbar.contentView.leftBarButtonItem = button
    }
    
    func addMessageToWilddog(chat:JSQMessage) {
        //在选择的房间号下进行添加消息
        let roomid = videoIDAndVideoName
        let roomref = WilddogManager.ref.childByAppendingPath(roomid)
        let messageKey = String(chat.date) + chat.senderId
        let messageValue = [
            "user":chat.senderDisplayName,
            "userid":chat.senderId,
            //                "headurl":chat.headImage,
            "time":String(chat.date),
            "message":chat.text
        ]
        roomref.updateChildValues([messageKey:messageValue])
    }
    
    func setUpSendUser() -> Void {
        //用户的id
        senderId = user.id
        //用户的名称
        senderDisplayName = user.name
        // view controller should automatically scroll to the most recent message
        automaticallyScrollsToMostRecentMessage = true
    }
        func setUpWilldog() -> Void {
            WilddogManager.wilddogLogin()
                /// 要评论的视频的根节点
            let videoRef = WilddogManager.ref.childByAppendingPath(videoIDAndVideoName)
    
            ///监听节点的变化, 获取最新的100  条评论
            videoRef.observeEventType(.ChildAdded, withBlock: { (shot) in
                guard let value = shot.value else {
                        /// 没有获取到任何的内容
                    return
                }
                        /// 对获取到的消息内容进行JSON 解析
                let messagesJson = JSON(value)
                    
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
                let time = dateFormatter.dateFromString(messagesJson["time"].stringValue)!
                let message = JSQMessage(senderId: messagesJson["userid"].stringValue, senderDisplayName: messagesJson["user"].stringValue, date: time, text: messagesJson["message"].stringValue)
                self.messages.append(message)
                self.collectionView.reloadData()
                })
            { (error) in
                print(error.localizedDescription)
            }
        }
}

//MARK: override JSQMessagesCollectionViewDataSource
extension ComiteViewController {
    //每个 item 显示的消息内容
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    //头像
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    //如果消息是自己的话 显示的背景颜色为 outgoingBubble
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        return messages[indexPath.item].senderId == user.id ? outgoingBubble : incomingBubble
    }
    
    
    //删除某一条聊天记录的操作
    override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
        
    }
    //显示网名
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.item]
        switch message.senderId {
        case user.id:
            return NSAttributedString(string: user.name)
        default:
            guard let senderDisplayName = message.senderDisplayName else {
                assertionFailure()
                return nil
            }
            return NSAttributedString(string: senderDisplayName)
        }
    }
    //显示时间
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
//        let message = messages[indexPath.item]
        return NSAttributedString(string: "")
    }
    //消息主体下边要显示的东西
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        return NSAttributedString(string: "")
    }
    
    
}
//MARK:  UICollectionViewDataSource
extension ComiteViewController {
    
    //显示的消息的条数
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
}
//MARK: override ComiteViewController Function
extension ComiteViewController {
    
    //按下附件按钮的操作
    override func didPressAccessoryButton(sender: UIButton!) {
        dismissViewControllerAnimated(true) { 
            
        }
    }
    // 按下发送按钮的操作
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        //初始化一条消息
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        //将消息添加到 messages 数组中
        addMessageToWilddog(message)
//        messages.append(message)
        finishSendingMessageAnimated(true)
//        collectionView.reloadData()
    }
}

//MARK: JSQMessagesCollectionViewDelegateFlowLayout

extension ComiteViewController {
    
    
    //消息上边要显示的网名的高度
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    //消息上边要显示的时间的高度
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    //消息下边要显示的高度
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
    //点击头像后的回调
    override func collectionView(collectionView: JSQMessagesCollectionView!, didTapAvatarImageView avatarImageView: UIImageView!, atIndexPath indexPath: NSIndexPath!) {
        print("点击头像后的回调")
    }
    
    //点击 message 的回调
    override func collectionView(collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAtIndexPath indexPath: NSIndexPath!) {
        print("点击 message 的回调")
    }
    
    //点击 cell 的回调
    override func collectionView(collectionView: JSQMessagesCollectionView!, didTapCellAtIndexPath indexPath: NSIndexPath!, touchLocation: CGPoint) {
        print("点击 cell 的回调")
    }
    
    //点击 TapLoadEarlierMessagesButton
    override func collectionView(collectionView: JSQMessagesCollectionView!, header headerView: JSQMessagesLoadEarlierHeaderView!, didTapLoadEarlierMessagesButton sender: UIButton!) {
        print("TapLoadEarlierMessagesButton")
    }
}