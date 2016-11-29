//
//  TodoItem.swift
//  ToDoListExercise
//
//  Created by Thomas Krentz on 21/11/16.
//  Copyright © 2016 Thomas Krentz. All rights reserved.
//

import Foundation

class TodoItem{
    
    var itemTitle: String
    var itemDescription: String?
    var itemDone: Bool=false
    
    init(itemTitle: String, itemDescription: String?) {
        self.itemTitle = itemTitle
        self.itemDescription = itemDescription
    }
    

}
