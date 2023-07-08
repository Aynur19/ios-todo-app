//
//  NetworkService.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

protocol NetworkService {
    func getList() async -> Result<TodoListResponse, Error>
    
    func patchList(with content: TodoListRequest) async -> Result<TodoListResponse, Error>
    
    func getItem(id: String) async -> Result<TodoItemResponse, Error>
    
    func postItem(with model: TodoItemRequest, revision: Int) async -> Result<TodoItemResponse, Error>
    
    func putItem(with model: TodoItemRequest, revision: Int) async -> Result<TodoItemResponse, Error>
}

private let baseUrlPropertyName = "ApiBaseUrl"
private let bearerTokenPropertyName = "BearerToken"

final class NetworkServiceImp: NetworkService {
    private let networkClient: NetworkClient
    private let baseUrlStr: String?
    private let bearerToken: String?
    
    init(with networkClient: NetworkClient) {
        self.networkClient = networkClient
        self.baseUrlStr = Configuration.getSharedValue(for: baseUrlPropertyName)
        self.bearerToken = Configuration.getPrivateValue(for: bearerTokenPropertyName)
    }
    
    func getList() async -> Result<TodoListResponse, Error> {
        var result: Result<TodoListResponse, Error>
        print("ЗАПРОС НА ПОЛУЧЕНИЕ СПИСКА ЭЛЕМЕНТОВ...")
        
        do {
            let httpRequest = try getHttpRequest(for: "/list")
            let getListResult: Result<TodoListResponse, Error> = await networkClient.performRequest(httpRequest: httpRequest)
            
            switch getListResult {
            case .success:
                let todoListResponse = try getListResult.get()
                result = .success(todoListResponse)
            case .failure(let error):
                result = .failure(error)
            }
        } catch {
            result = .failure(error)
        }
        
        return result
    }
    
    func patchList(with content: TodoListRequest) async -> Result<TodoListResponse, Error> {
        var result: Result<TodoListResponse, Error>
        print("ЗАПРОС НА СИНХРОНИЗАЦИЮ ДАННЫХ...")
        
        do {
            let jsonEncoder = JSONEncoder()
            let body = try jsonEncoder.encode(content)
            let httpRequest = try getHttpRequest(for: "/list", method: .patch, revision: "0", body: body)
            let getListResult: Result<TodoListResponse, Error> = await networkClient.performRequest(httpRequest: httpRequest)
            
            switch getListResult {
            case .success:
                let todoListResponse = try getListResult.get()
                result = .success(todoListResponse)
            case .failure(let error):
                result = .failure(error)
            }
        } catch {
            result = .failure(error)
        }
        
        return result
    }
    
    func getItem(id: String) async -> Result<TodoItemResponse, Error> {
        var result: Result<TodoItemResponse, Error>
        print("ЗАПРОС НА ПОЛУЧЕНИЕ КОНКРЕТНОГО ЭЛЕМЕНТА...")
        
        do {
            let httpRequest = try getHttpRequest(for: "/list/\(id)")
            let networkResult: Result<TodoItemResponse, Error> = await networkClient.performRequest(httpRequest: httpRequest)
            
            switch networkResult {
            case .success:
                let todoItemResponse = try networkResult.get()
                result = .success(todoItemResponse)
            case .failure(let error):
                result = .failure(error)
            }
        } catch {
            result = .failure(error)
        }
        
        return result
    }
    
    func postItem(with model: TodoItemRequest, revision: Int) async -> Result<TodoItemResponse, Error> {
        var result: Result<TodoItemResponse, Error>
        print("ЗАПРОС НА ДОБАВЛЕНИЕ ЭЛЕМЕНТА...")
        
        do {
            let jsonEncoder = JSONEncoder()
            let body = try jsonEncoder.encode(model)
            let httpRequest = try getHttpRequest(for: "/list/", method: .post, revision: "\(revision)", body: body)
            let networkResult: Result<TodoItemResponse, Error> = await networkClient.performRequest(httpRequest: httpRequest)
            
            switch networkResult {
            case .success:
                let todoItemResponse = try networkResult.get()
                result = .success(todoItemResponse)
            case .failure(let error):
                result = .failure(error)
            }
        } catch {
            result = .failure(error)
        }
        
        return result
    }
    
    func putItem(with model: TodoItemRequest, revision: Int) async -> Result<TodoItemResponse, Error> {
        var result: Result<TodoItemResponse, Error>
        print("ЗАПРОС НА ИЗМЕНЕНИЕ ЭЛЕМЕНТА...")
        
        do {
            let jsonEncoder = JSONEncoder()
            let body = try jsonEncoder.encode(model)
            let httpRequest = try getHttpRequest(for: "/list/\(model.element.id)", method: .put, revision: "\(revision)", body: body)
            let networkResult: Result<TodoItemResponse, Error> = await networkClient.performRequest(httpRequest: httpRequest)
            
            switch networkResult {
            case .success:
                let todoItemResponse = try networkResult.get()
                result = .success(todoItemResponse)
            case .failure(let error):
                result = .failure(error)
            }
        } catch {
            result = .failure(error)
        }
        
        return result
    }
    
    func getHttpRequest(for route: String, method: HttpMethod = .get, revision: String? = nil, body: Data? = nil) throws -> HttpRequest {
        guard let baseUrlStr = baseUrlStr else { throw HttpRequestError.baseUrlNotFound }
        guard let bearerToken = bearerToken else { throw HttpRequestError.bearerTokenNotFound }
        
        var headers = ["Authorization": bearerToken]
        if let revision = revision {
            headers["X-Last-Known-Revision"] = revision
        }
        
        return HttpRequest(route: "\(baseUrlStr)\(route)", headers: headers, body: body, httpMethod: method)
    }
}
