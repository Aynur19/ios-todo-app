//
//  URLSession.Ext.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 05.07.2023.
//

import Foundation

extension URLSession {
    
    func performTask(for urlRequest: URLRequest) async throws -> (data: Data, urlResponse: URLResponse) {
        print("      performTask() started...")
        return try await withCheckedThrowingContinuation { continuation in
            let task = dataTask(with: urlRequest) { (data, response, error) in
                print("        dataTask() started...")
                if let error = error {
                    continuation.resume(throwing: URLSessionError.failedTaskPerformingError(error: error))
                } else {
                    if let response = response {
                        if let data = data {
                            continuation.resume(returning: (data, response))
                        } else {
                            continuation.resume(throwing: URLSessionError.failedUnwrappingData(response: response))
                        }
                    } else {
                        continuation.resume(throwing: URLSessionError.failedUnwrappingResponse)
                    }
                }
            }
            
            if Task.isCancelled {
                task.cancel()
            } else {
                task.resume()
            }
        }
    }
}
