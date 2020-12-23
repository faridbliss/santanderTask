//
//  Stats.swift
//  API
//
//  Created by Farid Ullah on 19/12/2020.
//

import Foundation

public struct Stats: Codable {
    public let baseStat: Int
    public let effort: Int
    public let stat: PokemonModel

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort = "effort"
        case stat = "stat"
    }
}
