//
//  Category.swift
//  Todoey
//
//  Created by abc on 2021/05/25.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>() // forward relationship

    
}
