//
//  VideoViewController.swift
//  SunGod
//
//  Created by 太阳在线 on 16/6/1.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import SlackTextViewController

class VideoViewController: SLKTextViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
}
