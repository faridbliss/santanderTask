//
//  GameIndices.swift
//  API
//
//  Created by Farid Ullah on 19/12/2020.
//

import Foundation

public struct GameIndices: Codable {
   public let gameIndex: Int
   public let version: PokemonModel

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version = "version"
    }
}
