//
//  HttpRequest.Error.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

enum HttpRequestError: LocalizedError {
    
    case failedCreatingURLComponents(httpRequest: HttpRequest)
    case failedUnwrappingURL(httpRequest: HttpRequest)
    
    var errorDescription: String? {
        switch self {
        case .failedCreatingURLComponents(let httpRequest):
            return "ERROR: Error creating URLComponents from HttpRequest!" +
            "\n  HttpRequest: \(httpRequest)"
        case .failedUnwrappingURL(let httpRequest):
            return "ERROR: URL unwrapping failed!" +
            "\n  HttpRequest: \(httpRequest)"
        }
    }
}
