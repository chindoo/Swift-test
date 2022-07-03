//
//  UITableViewExtension.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 02/07/2022.
//

import UIKit

public extension UITableView {
    
    func dequeue<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(type.self)", for: indexPath) as! T
    }
}
