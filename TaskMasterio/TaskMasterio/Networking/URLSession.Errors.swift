//
//  URLSession.Errors.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 06.07.2023.
//

import Foundation

enum URLSessionError: LocalizedError {
    case failedCreationURL(str: String)
    case failedTaskPerformingError(error: Error)
    case failedUnwrappingResponse
    case failedUnwrappingData(response: URLResponse)
    
    var errorDescription: String? {
        switch self {
        case .failedCreationURL(let str):
            return "Failed to create URL! \n\tString: \(str)"
        case .failedTaskPerformingError(let error):
            return "Task performing error! \n\tError: \(error)"
        case .failedUnwrappingResponse:
            return "Response unwrapping failed!"
        case .failedUnwrappingData(let response):
            return "Data unprapping failed! \n\tResponse: \(response)"
        }
    }
}
