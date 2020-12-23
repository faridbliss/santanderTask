//
//  HomeDatsSource.swift
//  API
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation
import RxSwift

public protocol HomeDataSource {
    func fetchPokemon(limit: Int, offset: Int) -> Single<HomeResponse>
    func fetchPokemonDetail(id: String) -> Single<HomeDetailResponse>
}
