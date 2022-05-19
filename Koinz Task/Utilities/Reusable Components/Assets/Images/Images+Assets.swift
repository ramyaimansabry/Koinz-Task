//
//  Images+Assets.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import UIKit

extension UIImage {
    static let empty = "".uiImage
}

private extension String {
    var uiImage: UIImage {
        return UIImage(named: self) ?? UIImage()
    }
}
