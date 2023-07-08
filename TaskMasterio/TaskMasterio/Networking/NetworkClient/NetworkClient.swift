//
//  NetworkClient.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

protocol NetworkClient {
    func performRequest<T: Decodable>(httpRequest: HttpRequest) async -> Result<T, Error>
}
