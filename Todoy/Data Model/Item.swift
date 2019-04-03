//
//  Item.swift
//  Todoy
//
//  Created by Basma Said on 3/31/19.
//  Copyright © 2019 Basma Said. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
