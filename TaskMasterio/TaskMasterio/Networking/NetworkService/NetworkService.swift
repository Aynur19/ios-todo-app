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
    
    func deleteItem(with model: TodoItemRequest, revision: Int) async -> Result<TodoItemResponse, Error>
}

private let baseUrlPropertyName = "ApiBaseUrl"
private let bearerTokenPropertyName = "BearerToken"
private let maxRetries = 7
private let minDelay = 2.0
private let maxDelay = 2 * 4.0
private let factor = 1.5
private let jitter = 0.05

final class NetworkServiceImp: NetworkService {
    private let networkClient: NetworkClient
    private let baseUrlStr: String?
    private let bearerToken: String?
    
    init(with networkClient: NetworkClient) {
        self.networkClient = networkClient
        self.baseUrlStr = Configuration.getSharedValue(for: baseUrlPropertyName)
        self.bearerToken = Configuration.getPrivateValue(for: bearerTokenPropertyName)
    }
    
    func performRequest(httpRequest: HttpRequest, retryCount: Int, lastDelay: Double = 0) async -> Result<TodoListResponse, Error> {
        var result: Result<TodoListResponse, Error> = .failure(HttpRequestError.baseUrlNotFound)
        var delay = 0.0
        for attempt in 0...retryCount {
            do {
                let requestResult: Result<TodoListResponse, Error> = await networkClient.performRequest(httpRequest: httpRequest)
                switch requestResult {
                case .success:
                    let requestResponse = try requestResult.get()
                    return .success(requestResponse)
                case .failure(let error):
                    result = .failure(error)
                    print(error.localizedDescription)
                    if attempt > retryCount {
                        delay = getDelay(lastDelay: delay)
                        await sleep(delay)
                    } else {
                        throw error
                    }
                }
            } catch {
                result = .failure(error)
            }
        }
        return result
    }
    
    func performRequest(httpRequest: HttpRequest, retryCount: Int, lastDelay: Double = 0) async -> Result<TodoItemResponse, Error> {
        var result: Result<TodoItemResponse, Error> = .failure(HttpRequestError.baseUrlNotFound)
        var delay = 0.0
        for attempt in 0...retryCount {
            do {
                let requestResult: Result<TodoItemResponse, Error> = await networkClient.performRequest(httpRequest: httpRequest)
                switch requestResult {
                case .success:
                    let requestResponse = try requestResult.get()
                    return .success(requestResponse)
                case .failure(let error):
                    result = .failure(error)
                    print(error.localizedDescription)
                    if attempt > retryCount {
                        delay = getDelay(lastDelay: delay)
                        await sleep(delay)
                    } else {
                        throw error
                    }
                }
            } catch {
                result = .failure(error)
            }
        }
        return result
    }
    
    func sleep(_ seconds: TimeInterval) async {
        await Task.sleep(UInt64(seconds * 1_000_000_000))
    }
    
    private func getDelay(lastDelay: Double) -> Double {
        if lastDelay < 2 {
            return Double.random(in: minDelay...maxDelay) + jitter
        }
            
        return pow(1.5, lastDelay)
    }
    
    func getList() async -> Result<TodoListResponse, Error> {
        var result: Result<TodoListResponse, Error>
        print("ЗАПРОС НА ПОЛУЧЕНИЕ СПИСКА ЭЛЕМЕНТОВ...")
        
        do {
            let httpRequest = try getHttpRequest(for: "/list")
            result = await performRequest(httpRequest: httpRequest, retryCount: maxRetries)
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
            result = await performRequest(httpRequest: httpRequest, retryCount: maxRetries)
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
            result = await performRequest(httpRequest: httpRequest, retryCount: maxRetries)
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
            result = await performRequest(httpRequest: httpRequest, retryCount: maxRetries)
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
            result = await performRequest(httpRequest: httpRequest, retryCount: maxRetries)
        } catch {
            result = .failure(error)
        }
        
        return result
    }
    
    func deleteItem(with model: TodoItemRequest, revision: Int) async -> Result<TodoItemResponse, Error> {
        var result: Result<TodoItemResponse, Error>
        print("ЗАПРОС НА УДАЛЕНИЕ ЭЛЕМЕНТА...")
        
        do {
            let jsonEncoder = JSONEncoder()
            let body = try jsonEncoder.encode(model)
            let httpRequest = try getHttpRequest(for: "/list/\(model.element.id)", method: .delete, revision: "\(revision)", body: body)
            result = await performRequest(httpRequest: httpRequest, retryCount: maxRetries)
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
