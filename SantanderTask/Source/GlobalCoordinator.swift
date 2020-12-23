//
//  GlobalCoordinator.swift
//  SantanderTask
//
//  Created by Farid Ullah on 17/12/2020.
//

import UIKit
//
import RxSwift
import AppStart
import Base


class GlobalCoordinator: Coordinator <Void> {

    private var router: Router
    private var navigationController: BaseNavigationController
    public var window: UIWindow

    override init() {
        window = UIWindow()
        navigationController = BaseNavigationController()
        router = Router(navigationController: BaseNavigationController())
    }
    
    override func start() -> Observable<Void> {
        let viewModel = LaunchScreenViewModel()
        let controller = LaunchScreenViewController(viewModel: viewModel)

        let navigationController = BaseNavigationController(rootViewController: controller)

        navigationController.setNavigationBarHidden(false, animated: false)

        self.router = Router(navigationController: navigationController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        viewModel.launchScreenViewModelComplete.bind { [weak self] in
            guard let self = self else {return}
            let destinationCoordinator = HomeViewCoordinator(router: self.router)
            self.coordinate(to: destinationCoordinator).subscribe().disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)

        return Observable.never()
    }

}
