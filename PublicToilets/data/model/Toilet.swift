//
//  Toilet.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 01/07/2022.
//

import Foundation
import CoreLocation

struct Toilet {
    var recordId: String
    var openingHours: String?
    var hasPmrAccess: Bool
    var district: Int
    var location: CLLocation
    var address: String
    var additionalAddressInfos: String?
}
