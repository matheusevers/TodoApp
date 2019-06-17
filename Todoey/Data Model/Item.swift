//
//  Item.swift
//  Todoey
//
//  Created by Matheus Evers Rodrigues Fernandes on 17/06/19.
//  Copyright © 2019 Matheus Evers. All rights reserved.
//

import Foundation

class Item {
    var title : String = ""
    var done : Bool = false
    
    init(text: String, checked: Bool) {
        title = text
        done = checked
    }
}
