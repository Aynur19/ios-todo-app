//
//  NetworkClient.Imp.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

final class NetworkClientImp: NetworkClient {
    private var urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
        self.urlSession.configuration.timeoutIntervalForRequest = 3
    }
    
    func performRequest<T>(httpRequest: HttpRequest) async -> Result<T, Error> where T: Decodable {
        print("    HttpRequest: \(httpRequest)")
        var result: Result<T, Error>
        do {
            let urlRequest = try buildUrlRequest(from: httpRequest)
            let task = try await urlSession.performTask(for: urlRequest)
            
            let response = task.urlResponse
            let data = try HttpResponse.unicodeData(response, for: task.data)
            
            let handledResult = HttpResponse.handleResponse(for: response)
            switch handledResult {
            case .success:
                let jsonDecoder = JSONDecoder()
                let modelDto = try jsonDecoder.decode(T.self, from: data)
                result = .success(modelDto)
            case .failure(let error):
                throw error
            }
            
        } catch {
            result = .failure(error)
        }
        return result
    }
    
    private func buildUrlRequest(from httpRequest: HttpRequest) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: httpRequest.route) else {
            throw HttpRequestError.failedCreatingURLComponents(httpRequest: httpRequest)
        }

        let queryItems = httpRequest.queryItems.map { query in
            URLQueryItem(name: query.key, value: query.value)
        }

        urlComponents.queryItems = queryItems
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(
            of: "+", with: "%2B"
        )

        guard let url = urlComponents.url else {
            throw HttpRequestError.failedUnwrappingURL(httpRequest: httpRequest)
        }

        var urlRequest: URLRequest = .init(url: url)
        urlRequest.httpMethod = httpRequest.httpMethod.rawValue
        urlRequest.httpBody = httpRequest.body

        httpRequest.headers.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        return urlRequest
    }
}
