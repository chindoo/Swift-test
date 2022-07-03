//
//  Router.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 02/07/2022.
//

import Foundation

enum Router: Equatable {
    case toiletsList
    
    var baseUrl: String { API.baseUrl }
    var url: String { baseUrl + path }

    var path: String {
        switch self {
        case .toiletsList:
            return "/search"

        }
    }

    var parameters: [URLQueryItem]? {
        switch self {
        case .toiletsList:
            return [URLQueryItem(name: "dataset", value: "sanisettesparis2011")]
        }
    }

    var method: String {
        switch self {
        case .toiletsList:
            return "GET"
        }
    }

}

struct API {
    static var baseUrl: String { "https://data.ratp.fr/api/records/1.0/" }
}
