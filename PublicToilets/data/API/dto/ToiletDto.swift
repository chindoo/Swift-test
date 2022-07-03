//
//  ToiletDto.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 01/07/2022.
//

import Foundation

struct ToiletDto: Decodable {
    var dataSetId: String?
    var recordId: String?
    var toiletFields: ToiletFieldsDto?
    
    enum CodingKeys: String, CodingKey {
        case dataSetId = "datasetid"
        case recordId = "recordid"
        case toiletFields = "fields"
    }
}

struct ToiletFieldsDto: Decodable {
    var additionalAddress: String?
    var openingHours: String?
    var pmrAccess: String?
    var district: Int?
    var geoPoints: [Double]?
    var address: String?
    
    enum CodingKeys: String, CodingKey {
        case additionalAddress = "complement_adresse"
        case openingHours = "horaire"
        case pmrAccess = "acces_pmr"
        case district = "arrondissement"
        case geoPoints = "geo_point_2d"
        case address = "adresse"
    }
}
