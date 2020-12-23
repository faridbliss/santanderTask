//
//  AppStartCoordinator.swift
//  AppStart
//
//  Created by Farid Ullah on 17/12/2020.
//

import UIKit
//
import RxSwift
import Base

public class AppStartCoordinator: Coordinator<Void> {
      let window: UIWindow

      public init(window: UIWindow) {
          self.window = window
      }

      override public func start() -> Observable<Void> {
          let viewModel = LaunchScreenViewModel()
          let controller = LaunchScreenViewController(viewModel: viewModel)

          window.rootViewController = controller
          window.makeKeyAndVisible()

          return viewModel.launchScreenViewModelComplete
      }
}
