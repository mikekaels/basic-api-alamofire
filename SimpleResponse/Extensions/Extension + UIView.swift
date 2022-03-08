//
//  Extension + UIView.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 08/03/22.
//

import UIKit

extension UIView {

    func dropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 3)
        layer.masksToBounds = false
        layer.shadowOpacity = 0.1
//        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shadowRadius = 10
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
}
