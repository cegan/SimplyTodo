//
//  Todo.swift
//  SimplyToDo
//
//  Created by Casey Egan on 3/13/21.
//

import Foundation


final class Todo: Decodable {
  
    var id: String = ""
    var name: String!
    var order: Int = Int.random(in: 1...5000)
    var isComplete: Bool = false
    var statuses: [TodoStatus] = [TodoStatus(displayName: "Complete"),
                                  TodoStatus(displayName: "InComplete")]
  
    
    init() {

    }
    
    
    init(name: String) {
        self.name = name
        self.id = "0"
        self.order = Int.random(in: 1...5000)
        self.isComplete = false
        self.statuses = [TodoStatus(displayName: "Complete"),
                         TodoStatus(displayName: "InComplete")]
    }
    

    enum CodingKeys: String, CodingKey {
        case id
        case order
        case name
        case isComplete
    }
}



class TodoStatus {

    var displayName: String!
    var isSelected: Bool = false
   
    init(displayName: String) {
        self.displayName = displayName
    }
}





