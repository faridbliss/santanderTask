//
//  Types.swift
//  API
//
//  Created by Farid Ullah on 19/12/2020.
//

import Foundation

public struct Types: Codable {
    public let slot: Int
    public let type: PokemonModel

    enum CodingKeys: String, CodingKey {
        case slot = "slot"
        case type = "type"
    }
}
