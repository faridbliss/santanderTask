//
//  HomeDataManager.swift
//  API
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation
import Foundation
import RxSwift

public class HomeDataManager {
    let remoteDataSource: HomeRemoteDataSource
    public init(remoteDataSource: HomeRemoteDataSource = HomeRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    public func pokemon(limit: Int, offset: Int) -> Single<HomeResponse> {
        return remoteDataSource.fetchPokemon(limit: limit, offset: offset)
    }
    public func pokemonDetail(id: String) -> Single<HomeDetailResponse> {
        return remoteDataSource.fetchPokemonDetail(id: id)
    }
    
}
