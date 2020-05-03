//
//  RestClient.swift
//  TodoMVC
//
//  Created by Volodymyr Hryhoriev on 03.05.2020.
//  Copyright © 2020 Volodymyr Hryhoriev. All rights reserved.
//

import TodoModel
import CRDT
import Foundation

final class RestClient {
    static let url: URL = URL(string: "http://127.0.0.1:8080/todos")!

    func fetchList(_ completion: @escaping (AWSet<TodoItemDTO>?) -> Void) {
        var urlRequest = URLRequest(url: RestClient.url)
        urlRequest.httpMethod = "get"

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }

            guard let set = try? JSONDecoder().decode(AWSet<TodoItemDTO>.self, from: data) else {
                guard let plainSet = try? JSONDecoder().decode([TodoItemDTO].self, from: data), plainSet.isEmpty else {
                    completion(nil)
                    return
                }

                completion([])
                return
            }

            completion(set)
        }

        dataTask.resume()
    }

    func save(list: AWSet<TodoItemDTO>, completion: @escaping (Bool) -> Void) {
        var urlRequest = URLRequest(url: RestClient.url)
        urlRequest.httpMethod = "post"
        urlRequest.httpBody = try! JSONEncoder().encode(list)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(false)
                return
            }

            completion(true)
        }

        dataTask.resume()
    }
}
