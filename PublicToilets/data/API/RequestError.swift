//
//  RequestError.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 02/07/2022.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case offline
    case unknown

    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        default:
            return "Unknown error"
        }
    }
}
