//
//  UIApplication+UIHelpers.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import UIKit

extension UIApplication {
    var topController: UIViewController? {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        guard var topController = keyWindow?.rootViewController else { return nil }
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        
        return topController
    }
    
    var window: UIWindow? {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }
}
