//
//  todoService.swift
//  SimplyTodo
//
//  Created by Casey Egan on 3/13/21.
//

import Foundation
import Alamofire

final class TodoService {

    let baseUrl = "https://604bb216ee7cb900176a2816.mockapi.io/dtn-test/"
    
    func retrieveTodos(success: @escaping ([Todo]) -> Void) {
  
        AF.request("\(baseUrl)\("tasks/")").responseDecodable { (response: AFDataResponse<[Todo]>) in
            guard let todos = response.value else { return }
            success(todos)
        }
    }
    
    func retrieveTodo(withId: String, success: @escaping (Todo?) -> Void) {
        
        let url = "\(baseUrl)\("tasks/")\(withId)"
        
        AF.request(url, method: .get, parameters: nil, headers: nil).validate(statusCode: 200 ..< 299).responseDecodable { (response: AFDataResponse<Todo>) in
            
            switch response.result {
            case .success:
                guard let todo = response.value else { return }
                success(todo)
            case .failure:
                success(nil)
            }
        }
    }
    
    func deleteTodo(id: String, success: @escaping (Bool) -> Void) {
        
        AF.request("\(baseUrl)\("tasks/")\(id)", method: .delete, parameters: nil, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { response in

            switch response.result {
            case .success:
                success(true)
            case .failure:
                success(false)
            }
        }
    }
    
    func addTodo(todoToAdd: Todo, success: @escaping (Bool) -> Void) {
        
        let params: Parameters = [
            "name": todoToAdd.name,
            "isComplete": todoToAdd.isComplete,
            "order": todoToAdd.order,
            "createdAt": ""
        ]

        AF.request("\(baseUrl)\("tasks")", method: .post,
                                           parameters: params,
                                           encoding: JSONEncoding.default,
                                           headers: nil).validate(statusCode: 200 ..< 299).responseJSON { (response) in
                    
                switch response.result {
                case .success:
                    success(true)
                case .failure:
                    success(false)
                }
            }
        }
    
    
    func updateTodo(todoToUpdate: Todo, success: @escaping (Bool) -> Void) {
    
        let params: Parameters = [
            "name": todoToUpdate.name,
            "isComplete": todoToUpdate.isComplete,
            "order": todoToUpdate.order,
            "createdAt": ""
        ]
        
        AF.request("\(baseUrl)\("tasks/")\(todoToUpdate.id)",
                   method: .put,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: nil).validate(statusCode: 200 ..< 299).responseJSON { response in

                    
            switch response.result {
            case .success:
                success(true)
            case .failure:
                success(false)
            }
        }
    }
}
