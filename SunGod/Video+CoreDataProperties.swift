//
//  Video+CoreDataProperties.swift
//  SunGod
//
//  Created by 太阳在线 on 16/6/1.
//  Copyright © 2016年 太阳在线. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Video {

    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var des: String?
    @NSManaged var imageurl: String?
    @NSManaged var url: String?
    @NSManaged var time: String?
    @NSManaged var isdown: Bool
    @NSManaged var iscare: Bool
    @NSManaged var isplay: Bool
    @NSManaged var downurl: String?

}
