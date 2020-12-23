//
//  HomeDetailCoordinator.swift
//  SantanderTask
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation
import Foundation
import RxSwift
import Base

class HomeDetailCoordinator: Coordinator<Void> {
    private let router: Router
    private var url: String = ""
    private var name: String = ""
    
    init(router: Router, url: String, name: String){
        self.router = router
        self.url = url
        self.name = name
        super.init()
    }
    override func start() -> Observable<Void> {
        let viewModel = HomeDetailViewModel(url: url, name: name)
        let viewController = HomeDetailViewController(viewModel: viewModel)
        return router.rx.push(viewController, isAnimated: false)
    }
}
