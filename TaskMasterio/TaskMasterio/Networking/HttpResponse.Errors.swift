//
//  HttpResponse.Errors.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

private let errorStr = "ERROR:"

enum HttpResponseError: LocalizedError {
    case badRequest
    case authorizationError
    case notFound
    case internalServerError
    
    var errorDescription: String? {
        switch self {
        case .badRequest:
            let description = "\(errorStr) Bad request! Possible reasons: " +
            "\n  1) parts of the url or headings are missing;" +
            "\n  2) the known revision on the server and what is transferred (unsynchronizedData) do not match."
            return description
        case .authorizationError:
            return "\(errorStr) Authorization error!"
        case .notFound:
            return "\(errorStr) The requested resource is not found!"
        case .internalServerError:
            return "\(errorStr) Internal Server Error! Try again after a while!"
        }
    }
}
