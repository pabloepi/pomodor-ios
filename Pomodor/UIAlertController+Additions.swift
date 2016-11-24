//
//  UIAlertController+Additions.swift
//  Pomodor
//
//  Created by Pablo on 11/24/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit
import Foundation

extension UIAlertController {
    
    class func showAlert(_ title: String,
                         message: String,
                         callTitle: String,
                         callHandler: ((UIAlertAction) -> Void)?,
                         cancelTitle: String,
                         cancelHandler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let callAction   = UIAlertAction(title: callTitle,   style: .default, handler: callHandler)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel,  handler: cancelHandler)
        
        alertController.addAction(callAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    class func showWarningAlert(_ message: String) -> UIAlertController {
        
        return errorAlert("Oops!", message: message)
    }
    
    class func showErrorAlert(_ message: String) -> UIAlertController {
        
        return errorAlert("Something went wrong!", message: message)
    }
    
    // MARK: - Private Methods
    
    fileprivate class func errorAlert(_ title: String, message: String) -> UIAlertController {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let callAction = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: .none)
        
        alertController.addAction(callAction)
        
        return alertController
    }
    
}
