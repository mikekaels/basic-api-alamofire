//
//  Colors.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 07/03/22.
//

import UIKit
import SwiftUI

public enum Colors {
    static let title = UIColor.init("#292B2F")
    static let subTitle = UIColor.init("#B1B5B9")
    static let background = UIColor.init("#F2F4F5")
    static let cellBackground = UIColor.init("#FFFFFF")
    static let accent = UIColor.init("#DC4233")
    static let white = UIColor.init("#FFFFFF")
}


extension UIColor {

    static func colorWith(name:String) -> UIColor? {
        let selector = Selector("\(name)Color")
        if UIColor.self.responds(to: selector) {
            let color = UIColor.self.perform(selector).takeUnretainedValue()
            return (color as? UIColor)
        } else {
            return nil
        }
    }
}

extension UIColor {
    /// The SwiftUI color associated with the receiver.
    var suColor: Color { Color(self) }
}
