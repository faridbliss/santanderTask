//
//  HomeDetailViewModel.swift
//  SantanderTask
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation
import RxSwift
import Base
import API

class HomeDetailViewModel: BaseViewModel {
     let networkManager = HomeDataManager()
    var pokemonDetailData = PublishSubject<HomeDetailResponse>()
    var number: String = ""
    var name: String = ""

    required init(url: String, name: String) {
        super.init()
        self.number = url
        self.name = name
        networkManager.pokemonDetail(id: name).subscribe(onSuccess: { response in
            self.state.accept(.loaded)
            self.pokemonDetailData.onNext(response)
        }, onError: { error in}).disposed(by: disposeBag)
    }
    @available(*, unavailable)
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
