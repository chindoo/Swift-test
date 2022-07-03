//
//  UIStoryboardExtension.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 04/07/2022.
//

import UIKit

/// Instantiate a specific UIViewController type from storyboard
///
extension UIStoryboard {
    
    static func instantiate<T: UIViewController>(_ type: T.Type, in storyboardName: String? = nil, storyboardId: String? = nil) -> T {
        let storyboardName: String = storyboardName ?? T.className.deletingSuffix("ViewController")
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        }
        
        let storyboardId: String = storyboardId ?? T.className
        if let viewController = storyboard.instantiateViewController(withIdentifier: storyboardId) as? T {
            return viewController
        }
        
        fatalError("Could not instantiate \(T.className) identified by \(storyboardId) in \(storyboardName)")
    }
}

private extension String {
    
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}
