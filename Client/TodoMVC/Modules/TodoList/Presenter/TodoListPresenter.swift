//
//  TodoListPresenter.swift
//  TodoMVC
//
//  Created by Volodymyr Hryhoriev on 03.05.2020.
//  Copyright © 2020 Volodymyr Hryhoriev. All rights reserved.
//

final class TodoListPresenter {
    private let restClient = RestClient()

    func download(_ completion: @escaping (Bool) -> Void) {
        restClient.fetchList { set in
            guard let set = set else {
                completion(false)
                return
            }

            Store.shared.save(set: set)
            completion(true)
        }
    }

    func upload(_ completion: @escaping (Bool) -> Void) {
        let set = Store.shared.todoSet
        restClient.save(list: set) { isSuccess in
            completion(isSuccess)
        }
    }

    func clear(_ completion: @escaping (Bool) -> Void) {
        restClient.clear() { isSuccess in
            completion(isSuccess)
        }
    }
}
