//
//  StyleSheet.swift
//  Khari
//
//  Created by Evan Gruère on 09/12/2019.
//  Copyright © 2019 Evan Gruère. All rights reserved.
//

import UIKit

enum StyleSheetError : Error {
    case unsupportedProperty(named: String)
}

class StyleSheet: NSObject {
    
    let supportedProperties: [String] = [
        "backgroundColor",
        "constraints",
        "font",
        "textColor",
        "width"
    ]
    
    private let style: [String: Any]
    
    init(_ style: [String: Any]) {
        self.style = style
    }
    
    func value<T>(for property: String) throws -> T? {
        if (!isSupported(property)) {
            debugPrint("StyleSheetError - unsupported property : " + property)
            throw StyleSheetError.unsupportedProperty(named: property)
        }
        return self.style[property] as? T
    }
    
    func isSupported(_ property: String) -> Bool {
        return !self.supportedProperties.filter({ $0 == property }).isEmpty
    }
}

extension UIView {
    
    convenience init(styleSheet: StyleSheet) {
        self.init(frame: .zero)
        self.setStyle(styleSheet)
    }
    
    func setStyle(_ styleSheet: StyleSheet) {
        
        self.backgroundColor = try? styleSheet.value(for: "backgroundColor") ?? UIColor.clear
        
        if self is UILabel {
            let selfAsLabel = self as! UILabel
            selfAsLabel.textColor = try? styleSheet.value(for: "textColor") ?? UIColor.black
            selfAsLabel.font = try? styleSheet.value(for: "font") ?? UIFont.systemFont(ofSize: 17)
        }
    }

}
