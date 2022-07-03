//
//  ToiletService.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 02/07/2022.
//

import Foundation

struct ToiletService: HTTPClient {
    func getToiletList() async throws -> [Toilet] {
        let toiletListDto = try await sendRequest(endpoint: .toiletsList, responseModel: ToiletListDto.self)
        return ToiletMapper.mapList(dto: toiletListDto)
    }
}
