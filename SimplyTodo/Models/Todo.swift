//
//  Todo.swift
//  SimplyToDo
//
//  Created by Casey Egan on 3/13/21.
//

import Foundation


final class Todo: Decodable {
  
    var id: String!
    var order: Int
    var name: String!
    var isComplete: Bool
    var statuses: [TodoStatus] = [TodoStatus(displayName: "Complete"),
                                  TodoStatus(displayName: "InComplete")]
   // var createdAt: Date!
    
    
    init(name: String) {
        self.name = name
        self.order = 0
        self.id = "0"
        self.isComplete = false
        self.statuses = [TodoStatus(displayName: "Complete"),
                         TodoStatus(displayName: "InComplete")]
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case order
        case name
        case isComplete
       // case createdAt
    }
}






class TodoStatus {

    var displayName: String!
    var isSelected: Bool!
    var todoStatus: TodoStatusEnum = .none

    init(displayName: String) {
        self.displayName = displayName
        self.isSelected = false
        self.todoStatus = .none
    }
}


enum TodoStatusEnum: Int {
    case isComplete = 0
    case isInComplete = 1
    case none = 2
}



