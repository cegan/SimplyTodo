//
//  ApplicationTodos.swift
//  SimplyTodo
//
//  Created by Casey Egan on 3/13/21.
//

import Foundation


class ApplicationTodos {
    static let shared = ApplicationTodos()
    var todos: [Todo] = [Todo]()

    private init() { }
}
