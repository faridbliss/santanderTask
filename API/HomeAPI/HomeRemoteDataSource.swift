//
//  HomeRemoteDataSource.swift
//  API
//
//  Created by Farid Ullah on 18/12/2020.
//


import Foundation
import Foundation
import RxSwift

public class HomeRemoteDataSource: HomeDataSource {
    
    public func fetchPokemon(limit: Int, offset: Int) -> Single<HomeResponse> {
        NetworkManager.shared.fetchData(fromApi: HomeAPI.pokemon(limit: limit, offset: offset))
    }
    public func fetchPokemonDetail(id: String) -> Single<HomeDetailResponse> {
        NetworkManager.shared.fetchData(fromApi: HomeAPI.pokemonName(id: id))
    }
    public init() {}
    
}

