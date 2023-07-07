//
//  NetworkService.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

protocol NetworkService {
    func getTodoList() async -> Result<[TodoItem], Error>
}
                         
final class NetworkServiceImp: NetworkService {
    private let networkClient: NetworkClient
    
    init(with networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getTodoList() async -> Result<[TodoItem], Error> {
        let httpRequest = HttpRequest(route: "https://beta.mrdekk.ru/todobackend/list/",
                                      headers: ["Authorization": "Bearer tailpin"])
        
        let result: Result<TodoListResponse, Error> = await networkClient.getList(httpRequest: httpRequest)
        do {
            switch result {
            case .success:
                let todoList = try TodoItemMapper.mapToTodoList(from: result.get())
                return .success(todoList)
            case .failure(let error):
                return .failure(error)
            }
        } catch {
            return .failure(error)
        }
    }
}
