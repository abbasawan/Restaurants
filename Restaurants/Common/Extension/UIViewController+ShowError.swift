//
//  UIViewController+ShowError.swift
//  Restaurants
//
//  Created by Abbas Awan on 24.08.20.
//  Copyright © 2020 Takeaway. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Show an error alert
    /// - Parameter error: Error object which needs to be shown to the user
    func show(_ error: Error) {
        show(title: "Error".localized, message: error.localizedDescription)
    }
    
    /// Show a message alert. It contains OK button as the default action
    /// - Parameters:
    ///   - title: Title of the alert
    ///   - message: Message body of the alert
    func show(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK".localized,
                                                style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
