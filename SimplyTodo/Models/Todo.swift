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
   // var completed: Bool
   // var createdAt: Date!
    
    
    init(name: String) {
        self.name = name
        self.order = 0
        self.id = "0"
        self.isComplete = true
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case order
        case name
        case isComplete
       // case completed
       // case createdAt
    }
}
