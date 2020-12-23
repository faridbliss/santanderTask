//
//  Drawable.swift
//  Base
//
//  Created by Farid Ullah on 17/12/2020.
//

import UIKit

public protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    public var viewController: UIViewController? { return self }
}
