//
//  HomeViewController.swift
//  SantanderTask
//
//  Created by Farid Ullah on 17/12/2020.
//

import Foundation
import Base
import Resources
import RxCocoa
import RxSwift
import UIKit

class HomeViewController: BaseViewController <HomeViewModel, HomeView> {
    var offset: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
       
    }
    override func bindUI() {
        super.bindUI()
        setupCollectionView()
        self.viewModel.getPokenmonValue.onNext((20, offset))
        _view.refreshControl
                .rx.controlEvent(.valueChanged)
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.offset += 20
                    self.viewModel.getPokenmonValue.onNext((20, self.offset))
                    self._view.refreshControl.endRefreshing()
                    }, onCompleted: nil, onDisposed: nil)
                .disposed(by: disposeBag)
    }
    override func setNavigationItems() {
        super.setNavigationItems()
        self.title = R.string.base.homeTilte()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: nil, style:.plain, target: nil, action: nil)

    }
    private func setupCollectionView(){
        viewModel.pokemonData.bind(to: _view
                                    .collectionView.rx.items(cellIdentifier: String(describing: HomeCollectionCell.self),
                                                             cellType: HomeCollectionCell.self)) {  (row,item,cell) in
            cell.configureCell(text: item.name, url: item.url)
        }.disposed(by: disposeBag)

        _view.collectionView.rx.itemSelected
            .map { index in
                return (index, self.viewModel.pokemonData.value[index.row])
            }
            .subscribe(onNext: { [weak self] index, model in
                guard let self = self else { return }
                self.viewModel.pokemonDetail.onNext((model.name, model.url))
            }).disposed(by: disposeBag)
    }
}
