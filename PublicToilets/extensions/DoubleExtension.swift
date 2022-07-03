//
//  DoubleExtension.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 03/07/2022.
//

import Foundation

extension Double {
    
    func standardFormatDistance() -> String {
        var newDistance: Double = 0
        var format: String = ""
        
        if (self < 1000) {
            format = "%@ m";
        } else {
            format = "%@ km";
            newDistance = self / 1000;
        }
        
        return String(format: format, newDistance.stringWithDouble())
    }
    
    func stringWithDouble() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter.string(from: NSNumber(value: self as Double))!
    }
}
