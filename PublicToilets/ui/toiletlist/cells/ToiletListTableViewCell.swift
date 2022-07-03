//
//  ToiletListTableViewCell.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 02/07/2022.
//

import UIKit

class ToiletListTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var openingHoursLabel: UILabel!
    @IBOutlet private weak var pmrAccessLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    
    // MARK: Setup
    
    func setup(with toilet: Toilet, distance: String?) {
        let pmrAccessText = toilet.hasPmrAccess ? "Oui" : "Non"
        addressLabel.text = "Adresse: \(toilet.address), \(toilet.district)"
        openingHoursLabel.text = "Horaire: \(toilet.openingHours ?? "N/A")"
        pmrAccessLabel.text = "Accès mobilité réduite: \(pmrAccessText)"
        distanceLabel.text = "Distance: \(distance ?? "N/A")"
    }
}
