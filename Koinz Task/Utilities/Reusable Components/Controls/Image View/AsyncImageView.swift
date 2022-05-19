//
//  AsyncImageView.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import UIKit
import SDWebImage

@IBDesignable
class AsyncImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        sd_imageIndicator = SDWebImageActivityIndicator.large
    }
    
    func setImage(using url: String?) {
        sd_setImage(with: URL(string: url.value), completed: nil)
    }
}
