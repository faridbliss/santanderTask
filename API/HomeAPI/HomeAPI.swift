//
//  HomeAPI.swift
//  API
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation
import Foundation
import Moya

public enum HomeAPI {
    case pokemon(limit: Int, offset: Int)
    case abilities(id: String)
    case characteristics(id: String)
    case eggGroups(id: String)
    case genders(id: String)
    case growthRates(id: String)
    case natures(id: String)
    case pokeathlonStats(id: String)
    case pokemonName(id: String)
    case pokemonLocationAreas(id: String)
    case pokemonColors(id: String)
    case pokemonForms(id: String)
    case pokemonHabitats(id: String)
    case pokemonShapes(id: String)
    case pokemonSpecies(id: String)
    case stats(id: String)
    case types(id: String)
}

extension HomeAPI: TargetType {

    public var headers: [String: String]? {
           var _headers: [String: String] = [:]
        _headers[HeaderType.accept.rawValue] = HeaderValue.applicationJson.rawValue
           return _headers
       }

    public var path: String {
        switch self {
        case .pokemon:
            return "/pokemon"
        case .abilities(id: let id):
            return "/pokemon/\(id)/"
        case .characteristics(id: let id):
            return "/pokemon/\(id)/"
        case .eggGroups(id: let id):
            return "/pokemon/\(id)/"
        case .genders(id: let id):
            return "/pokemon/\(id)/"
        case .growthRates(id: let id):
            return "/pokemon/\(id)/"
        case .natures(id: let id):
            return "/pokemon/\(id)/"
        case .pokeathlonStats(id: let id):
            return "/pokemon/\(id)/"
        case .pokemonLocationAreas(id: let id):
            return "/pokemon/\(id)/"
        case .pokemonColors(id: let id):
            return "/pokemon/\(id)/"
        case .pokemonForms(id: let id):
            return "/pokemon/\(id)/"
        case .pokemonHabitats(id: let id):
            return "/pokemon/\(id)/"
        case .pokemonShapes(id: let id):
            return "/pokemon/\(id)/"
        case .pokemonSpecies(id: let id):
            return "/pokemon/\(id)/"
        case .stats(id: let id):
            return "/pokemon/\(id)/"
        case .types(id: let id):
            return "/pokemon/\(id)/"
        case .pokemonName(id: let id):
            return "/pokemon/\(id)/"
        }
    }

    public var method: Moya.Method  {
        switch self {
        case .pokemon,
             .abilities,
             .characteristics,
             .eggGroups,
             .genders, .pokemonName,
             .growthRates, .natures, .pokeathlonStats, .pokemonLocationAreas, .pokemonColors, .pokemonForms, .pokemonHabitats,
             .pokemonShapes, .pokemonSpecies, .stats, .types:
            return .get

        }
    }

    public var task: Task {
        switch self {
        case .pokemon(let limit, let offset):
            return .requestParameters(parameters: ["offset": offset, "limit": limit], encoding: URLEncoding.default)
        case .abilities,
             .characteristics,
             .eggGroups,
             .genders,
             .growthRates, .natures, .pokeathlonStats, .pokemonLocationAreas, .pokemonColors, .pokemonForms, .pokemonHabitats,
             .pokemonShapes, .pokemonName, .pokemonSpecies, .stats, .types:
            return .requestPlain
        }
    }
}
