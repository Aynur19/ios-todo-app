//
//  HttpRequest.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

struct HttpRequest {
    let route: String
    let headers: [String: String]
    let body: Data?
    let queryItems: [(key: String, value: String?)]
    let httpMethod: HttpMethod

    init(
        route: String,
        headers: [String: String] = [:],
        body: Data? = nil,
        queryItems: [(key: String, value: String?)] = [],
        httpMethod: HttpMethod = .get
    ) {
        self.route = route
        self.headers = headers
        self.body = body
        self.queryItems = queryItems
        self.httpMethod = httpMethod
    }
}
