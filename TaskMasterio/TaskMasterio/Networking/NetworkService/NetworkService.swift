//
//  NetworkService.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

protocol NetworkService {
    func getTodoList() async -> Result<TodoListResponse, Error>
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
    
    func getTodoList() async -> Result<TodoListResponse, Error> {
        var result: Result<TodoListResponse, Error>
        
        do {
            let httpRequest = try getHttpRequest(for: "/list")
            let getListResult: Result<TodoListResponse, Error> = await networkClient.getList(httpRequest: httpRequest)
            
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
    
    func getHttpRequest(for route: String) throws -> HttpRequest {
        guard let baseUrlStr = baseUrlStr else { throw HttpRequestError.baseUrlNotFound }
        guard let bearerToken = bearerToken else { throw HttpRequestError.bearerTokenNotFound }
        
        return HttpRequest(route: "\(baseUrlStr)\(route)", headers: ["Authorization": bearerToken])
    }
}
