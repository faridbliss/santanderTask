//
//  HeldItems.swift
//  API
//
//  Created by Farid Ullah on 19/12/2020.
//

import Foundation

public struct HeldItems: Codable {
   public let item: PokemonModel
   public let versionDetail: [VersionDetail]

    enum CodingKeys: String, CodingKey {
        case item = "item"
        case versionDetail = "version_details"
    }
}

public struct VersionDetail: Codable {
    public let rarity: Int
    public let version: PokemonModel
    
    enum CodingKeys: String, CodingKey {
        case rarity = "rarity"
        case version = "version"
    }
}
