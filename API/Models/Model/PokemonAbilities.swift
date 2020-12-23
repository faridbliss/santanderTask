//
//  PokemonAbilities.swift
//  API
//
//  Created by Farid Ullah on 19/12/2020.
//

import Foundation

public struct PokemonAbilities: Codable {
   public let slot: Int
   public let isHidden: Bool
   public let ability: PokemonModel

    enum CodingKeys: String, CodingKey {
        case slot = "slot"
        case isHidden = "is_hidden"
        case ability = "ability"
    }
}
