//
//  Category.swift
//  Todoey
//
//  Created by Matheus Evers Rodrigues Fernandes on 18/06/19.
//  Copyright © 2019 Matheus Evers. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var cellColour : String = ""
    
    let items = List<Item>()
}
