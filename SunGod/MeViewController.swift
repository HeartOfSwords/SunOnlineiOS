//
//  MeViewController.swift
//  SunGod
//
//  Created by 太阳在线 on 16/5/23.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import PKHUD

class MeViewController: UITableViewController {

    
   
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        title = "ME"

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let id = segue.identifier else {
            return
        }
        switch id {
        case "godown":
            let vc = segue.destinationViewController as! UserSeeCacheViewController
            vc.type = 0
        case "goCare":
            let vc = segue.destinationViewController as! UserSeeCacheViewController
            vc.type = 2
        case "goplay":
            let vc = segue.destinationViewController as! UserSeeCacheViewController
            vc.type = 1
        default:
            break
        }
        
    }
    
    func setUpNav() -> Void {
        addLeftBarButtonWithImage(UIImage(named: leftMenuImageName)!)
    }
    

    @IBAction func alloweSee(sender: UISwitch) {
        Defaults[.allowSee] = sender.on
        Defaults.synchronize()
        if sender.on {
            HUD.flash(HUDContentType.LabeledSuccess(title: "设置成功", subtitle: "你开启了WWAN网络观看视频"), delay: 1)
        }else {
            HUD.flash(HUDContentType.LabeledSuccess(title: "设置成功", subtitle: "你关闭了WWAN网络观看视频"), delay: 1)
        }
        
    }
    
    @IBAction func alloewDown(sender: UISwitch) {
        Defaults[.allowDown] = sender.on
        Defaults.synchronize()
        if sender.on {
            HUD.flash(HUDContentType.LabeledSuccess(title: "设置成功", subtitle: "你开启了WWAN网络下载视频"), delay: 1)
        }else {
            HUD.flash(HUDContentType.LabeledSuccess(title: "设置成功", subtitle: "你关闭了WWAN网络下载视频"), delay: 1)
        }
        
    }
    
}

//MARK: UITableViewDelegate
extension MeViewController {
    
}


//MARK: UITableViewDataSource
extension MeViewController {

}

