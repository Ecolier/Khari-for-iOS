//
//  Theme.swift
//  Khari
//
//  Created by Evan Gruère on 05/12/2019.
//  Copyright © 2019 Evan Gruère. All rights reserved.
//

import Foundation
import SwiftUI

class Palette {
    static var lightGray = Color(white: 0.92)
}

class Padding {
    static let small: CGFloat = 8
    static let medium: CGFloat = 16
    static let large: CGFloat = 24
}

struct LabelTheme {
    static let body = StyleSheet([
        "font": UIFont.systemFont(ofSize: 17),
        "textColor": UIColor.label,
    ])
    static let caption = StyleSheet([
        "font": UIFont.systemFont(ofSize: 12),
        "textColor": UIColor.secondaryLabel,
    ])
}
