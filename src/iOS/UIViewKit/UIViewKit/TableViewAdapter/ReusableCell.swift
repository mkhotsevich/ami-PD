//
//  ReusableCell.swift
//  UIViewKit
//
//  Created by Artem Kufaev on 25.04.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

<<<<<<< HEAD
public protocol ReusableCell: UITableViewCell {
=======
public protocol ReusableCell {
>>>>>>> ios/feature/uiviewkit
    static var reuseIdentifier: String { get }
}

public extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
