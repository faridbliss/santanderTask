//
//  UIImageView+Extensions.swift
//  UIComponents
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation
import Kingfisher

extension UIImageView {
    public func changeImageColor(to color: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
    public typealias CompletionHandler = (_ success:Bool) -> Void

    public func image(with urlString: String?,
                      shouldHideOnError: Bool = false,
                      placeHolderImage: UIImage? = nil,
                      completionHandler: CompletionHandler? = nil) {

        if let imageUrl = urlString, let image = URL(string: imageUrl) {
            kf.setImage(
                with: image,
                placeholder: placeHolderImage,
                options: [
                    .cacheOriginalImage
                ], completionHandler: {
                result in
                switch result {
                case .failure:
                    self.isHidden = shouldHideOnError
                    completionHandler?(false)
                case .success:
                    self.isHidden = false
                    completionHandler?(true)
                }
            })
        } else {
            isHidden = shouldHideOnError
            image = placeHolderImage
        }
    }
}

