//
//  HttpClient.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 02/07/2022.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Router, responseModel: T.Type) async throws -> T
}

extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Router,
        responseModel: T.Type
    ) async throws -> T {

        var request = URLComponents(string: endpoint.url)!

        if let parameters = endpoint.parameters {
            request.queryItems = parameters
        }

        guard let url = request.url else { throw RequestError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = endpoint.method

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    throw RequestError.decode
                }
                return decodedResponse
                
            default:
                throw RequestError.unknown
            }
        } catch URLError.Code.notConnectedToInternet {
            throw RequestError.offline
        }
    }
}
