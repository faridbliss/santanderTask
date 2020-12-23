//
//  HomeViewModel.swift
//  SantanderTask
//
//  Created by Farid Ullah on 17/12/2020.
//

import Foundation
import RxSwift
import RxCocoa
import Base
import API

class HomeViewModel: BaseViewModel {
    var pokemonData = BehaviorRelay<[PokemonModel]>(value: [])
    var pokemonDataPlus = BehaviorRelay<[PokemonModel]>(value: [])
    var networkManager = HomeDataManager()
    var pokemonDetail = PublishSubject<(name: String, url: String)>()
    var getPokenmonValue = PublishSubject<(limit: Int, offset: Int)>()

    
    required init() {
        super.init()
        self.state.accept(.isLoading)
        getPokenmonValue.bind { [weak self] limit, offset in
            guard let self = self else {return}
            self.getPokemon(limit: limit, offset: offset)
        }.disposed(by: disposeBag)
    }
    private func getPokemon(limit: Int, offset: Int) {
        networkManager.pokemon(limit: limit, offset: offset).subscribe(onSuccess: { response in
            self.state.accept(.loaded)
            self.pokemonDataPlus.accept(self.pokemonData.value)
            self.pokemonData.accept(response.result + self.pokemonDataPlus.value)
        }, onError: { error in}).disposed(by: disposeBag)
    }
}
