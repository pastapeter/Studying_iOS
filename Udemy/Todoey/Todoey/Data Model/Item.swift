//
//  Item.swift
//  Todoey
//
//  Created by abc on 2021/05/25.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    //.self 하면 타입이됨
}
