//
//  HomeDetailViewController.swift
//  SantanderTask
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation
import Foundation
import Base
import Resources
import RxCocoa
import RxSwift
import UIKit

class HomeDetailViewController: BaseViewController <HomeDetailViewModel, HomeDetailView> {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func bindUI() {
        super.bindUI()
        _view.configureView(text: viewModel.name, number: viewModel.number)
        viewModel.pokemonDetailData.bind { [weak self] response in
            guard let self = self else {return}
            self._view.configureDetail(data: response)
        }.disposed(by: disposeBag)

    }
    override func setNavigationItems() {
        super.setNavigationItems()
        self.title = R.string.base.homeDetailTitle()
    }
}
