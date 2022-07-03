//
//  Navigator.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 04/07/2022.
//

import Foundation
import UIKit

class Navigator {
    
    // MARK: Dependencies
    
    private weak var viewController: UIViewController?

    private weak var navigationController: UINavigationController? {
        viewController?.navigationController
    }
    
    // MARK: Init
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: Details
    
    func toToiletDetails(_ toilet: Toilet) {
        let detailsVC = UIStoryboard.instantiate(ToiletDetailsViewController.self, in: "ToiletDetails")
        detailsVC.setup(with: toilet)
        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
