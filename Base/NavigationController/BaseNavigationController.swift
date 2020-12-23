//
//  BaseNavigationController.swift
//  Base
//
//  Created by Farid Ullah on 17/12/2020.
//

import Foundation
import Foundation
import UIKit
import MaterialComponents.MaterialNavigationBar
import AppConstants

open class BaseNavigationController: UINavigationController {

    public override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
          viewControllerToPresent.modalPresentationStyle = .fullScreen
          self.modalPresentationStyle = .fullScreen
          super.present(viewControllerToPresent, animated: flag, completion: completion)
      }
    public override func viewWillLayoutSubviews() {
         applyStyle()
     }

    public func applyStyle() {
        navigationBar.barTintColor = AppConstants.Colors.navigationDefaultColor
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}
