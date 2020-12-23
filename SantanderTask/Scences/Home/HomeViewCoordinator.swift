//
//  HomeViewCoordinator.swift
//  SantanderTask
//
//  Created by Farid Ullah on 17/12/2020.
//

import Foundation
import RxSwift
import Base

class HomeViewCoordinator: Coordinator<Void> {
    private let router: Router
    init(router: Router){
        self.router = router
        super.init()
    }

    override func start() -> Observable<Void> {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        viewModel.pokemonDetail.bind { [weak self] value in
            guard let self = self else {return}
            let splitStr = value.url.components(separatedBy: "/").dropLast()
            let destinationCoordinator = HomeDetailCoordinator(router: self.router, url: splitStr.last ?? "", name: value.name)
            self.coordinate(to: destinationCoordinator).subscribe().disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        return router.rx.push(viewController, isAnimated: false)
    }
}
