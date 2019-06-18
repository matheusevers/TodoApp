//
//  Item.swift
//  Todoey
//
//  Created by Matheus Evers Rodrigues Fernandes on 18/06/19.
//  Copyright © 2019 Matheus Evers. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    var parentCategoty = LinkingObjects(fromType: Category.self, property: "items")
}
