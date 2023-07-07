//
//  HttpResponse.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

struct HttpResponse {
    static func unicodeData(_ response: URLResponse, for data: Data, encodind: String.Encoding = .utf8) throws -> Data {
        guard let dataStr = String(data: data, encoding: .utf8) else {
            throw HttpResponseError.failedUnicodeData(urlResponse: response)
        }
        
        return Data(dataStr.utf8)
    }
    
    static func handleResponse(for response: URLResponse) -> Result<Void, HttpResponseError> {
        guard let response = response as? HTTPURLResponse else {
            return .failure(.failedUnwrappingHTTPURLResponse(urlResponse: response))
        }
        
        switch response.statusCode {
        case 200: return .success(())
        case 400: return .failure(.badRequest(httpResponse: response))
        case 401: return .failure(.authorizationError(httpResponse: response))
        case 404: return .failure(.notFound(httpResponse: response))
        case 500...599: return .failure(.internalServerError(httpResponse: response))
        default: return .failure(.unhandledError(httpResponse: response))
        }
    }
}
