//
//  Moves.swift
//  API
//
//  Created by Farid Ullah on 19/12/2020.
//

import Foundation

public struct Moves: Codable {
   public let move: PokemonModel
   public let versionGroupDetail: [VersionGroupDetail]

    enum CodingKeys: String, CodingKey {
        case move = "move"
        case versionGroupDetail = "version_group_details"
    }
}

public struct VersionGroupDetail: Codable {
    public let levelLearnedAt: Int
    public let versionGroup: PokemonModel
    public let moveLearnMethod: PokemonModel

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case versionGroup = "version_group"
        case moveLearnMethod = "move_learn_method"
    }
}
