//
//  Item.swift
//  Todoy
//
//  Created by Basma Said on 3/13/19.
//  Copyright © 2019 Basma Said. All rights reserved.
//

import Foundation

class Item: Codable {     //because it's custtome class should encoded and decodable-->codable
    var title: String = ""
    var done:Bool = false
}
