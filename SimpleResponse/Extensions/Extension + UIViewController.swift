//
//  Extension + UIViewController.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 08/03/22.
//

import UIKit

extension UIViewController: Alertable {
    open func noInternetConnection(_ isNoInternetConnection: Bool,
                                   completion: @escaping() -> Void) {
        if isNoInternetConnection {
            self.showAlert(title: "Whoops!",
                      message: "Please check your network connection and try again.",
                      actionTitle: "Try Again", completion: completion)
        }
    }
}
