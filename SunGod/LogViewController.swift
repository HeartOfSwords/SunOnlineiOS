//
//  LogViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/6/6.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
