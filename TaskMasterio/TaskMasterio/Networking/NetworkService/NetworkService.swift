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
        print("  networkService.getTodoList() started...")
        
        guard let baseUrlStr = baseUrlStr else { return .failure(HttpRequestError.baseUrlNotFound) }
        guard let bearerToken = bearerToken else { return .failure(HttpRequestError.bearerTokenNotFound) }
        
        let httpRequest = HttpRequest(route: "\(baseUrlStr)/list/", headers: ["Authorization": bearerToken])
        let getListResult: Result<TodoListResponse, Error> = await networkClient.getList(httpRequest: httpRequest)
        
        print("  networkClient.getList() returned result...")
        do {
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
}
