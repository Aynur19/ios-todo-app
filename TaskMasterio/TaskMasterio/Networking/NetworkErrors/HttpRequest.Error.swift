//
//  HttpRequest.Error.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

enum HttpRequestError: LocalizedError {
    
    case baseUrlNotFound
    case bearerTokenNotFound
    case failedCreatingURLComponents(httpRequest: HttpRequest)
    case failedUnwrappingURL(httpRequest: HttpRequest)
    
    var errorDescription: String? {
        switch self {
        case .baseUrlNotFound:
            return "ERROR: Base URL not found from config file! " +
            "Check for the presence of the file and the presence of the necessary key and value to get the base URL for working with the API!"
        case .bearerTokenNotFound:
            return "ERROR: Bearer token not found from config file! " +
            "Check for the presence of the file and the presence of the necessary key and value to get the base URL for working with the API!"
        case .failedCreatingURLComponents(let httpRequest):
            return "ERROR: Error creating URLComponents from HttpRequest!" +
            "\n  HttpRequest: \(httpRequest)"
        case .failedUnwrappingURL(let httpRequest):
            return "ERROR: URL unwrapping failed!" +
            "\n  HttpRequest: \(httpRequest)"
        }
    }
}
