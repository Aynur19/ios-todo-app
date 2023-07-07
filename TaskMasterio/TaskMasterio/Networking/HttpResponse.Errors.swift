//
//  HttpResponse.Errors.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

enum HttpResponseError: LocalizedError {
    
    case failedUnicodeData(urlResponse: URLResponse)
    case failedUnwrappingHTTPURLResponse(urlResponse: URLResponse)
    case badRequest(httpResponse: HTTPURLResponse)
    case authorizationError(httpResponse: HTTPURLResponse)
    case notFound(httpResponse: HTTPURLResponse)
    case internalServerError(httpResponse: HTTPURLResponse)
    case unhandledError(httpResponse: HTTPURLResponse)
    
    var errorDescription: String? {
        switch self {
        case .failedUnicodeData(let urlResponse):
            return "ERROR: Error converting the data received from the response to the request into a string with UTF-8 encoding!" +
            "\n  URLResponse: \(urlResponse)"
        case .failedUnwrappingHTTPURLResponse(let urlResponse):
            return "ERROR: HTTPURLResponse unwrapping failed!" +
            "\n  URLResponse: \(urlResponse)"
        case .badRequest(let httpResponse):
            return "ERROR: Bad request! Possible reasons: " +
            "\n  1) parts of the url or headings are missing;" +
            "\n  2) the known revision on the server and what is transferred (unsynchronizedData) do not match." +
            "\n  HTTPURLResponse: \(httpResponse)"
        case .authorizationError(let httpResponse):
            return "ERROR: Authorization error!" +
            "\n  HTTPURLResponse: \(httpResponse)"
        case .notFound(let httpResponse):
            return "ERROR: The requested resource is not found!" +
            "\n  HTTPURLResponse: \(httpResponse)"
        case .internalServerError(let httpResponse):
            return "ERROR: Internal Server Error! Try again after a while!" +
            "\n  HTTPURLResponse: \(httpResponse)"
        case .unhandledError(let httpResponse):
            return "ERROR: Unhandled Error! Try again after a while!" +
            "\n  HTTPURLResponse: \(httpResponse)"
        }
    }
}
