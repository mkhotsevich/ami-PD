//
//  ColorPalette.swift
//  UIUtils
//
//  Created by Artem Kufaev on 29.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import SwiftUI
import UIUtils

public enum ColorPalette {
    case main
    case secondary
    
    public func color() -> UIColor {
        switch self {
        case .main: return UIColor(rgb: 0x00BCB4)
        case .secondary: return UIColor(rgb: 0xB9D4DB)
        }
    }
    
    public func color() -> Color {
        return Color(color())
    }
}
