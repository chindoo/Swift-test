//
//  ToiletMapper.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 01/07/2022.
//

import Foundation
import CoreLocation

enum ToiletMapper {
    
    static func mapList(dto: ToiletListDto) -> [Toilet] {
        guard let records = dto.records else { return [] }
        return records.compactMap { map(dto: $0) }
    }
    
    static func map(dto: ToiletDto) -> Toilet? {
        guard let recordId = dto.recordId,
              let toiletFieldsDto = dto.toiletFields,
              let pmrAccess = toiletFieldsDto.pmrAccess,
              let district = toiletFieldsDto.district,
              let geoPoints = toiletFieldsDto.geoPoints,
              let address = toiletFieldsDto.address else {
            return nil
        }
        
        let hasPmrAccess = pmrAccess == "Oui"
        let location = CLLocation(latitude: geoPoints[0], longitude: geoPoints[1])
        
        return Toilet(recordId: recordId,
                      openingHours: toiletFieldsDto.openingHours,
                      hasPmrAccess: hasPmrAccess,
                      district: district,
                      location: location,
                      address: address,
                      additionalAddressInfos: toiletFieldsDto.additionalAddress)
    }
}
