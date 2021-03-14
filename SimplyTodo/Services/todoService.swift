//
//  todoService.swift
//  SimplyTodo
//
//  Created by Casey Egan on 3/13/21.
//

import Foundation
import Alamofire

final class todoService {
    
    func retrieveTodos(success: @escaping ([Todo]) -> Void) {
        AF.request("https://604bb216ee7cb900176a2816.mockapi.io/dtn-test/tasks").responseDecodable { (response: AFDataResponse<[Todo]>) in
            guard let todos = response.value else { return }
            success(todos)
        }
    }
}
