//
//  Category.swift
//  Todoy
//
//  Created by Basma Said on 3/31/19.
//  Copyright © 2019 Basma Said. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
