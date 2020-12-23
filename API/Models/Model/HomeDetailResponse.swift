//
//  HomeDetailResponse.swift
//  API
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation

public struct HomeDetailResponse: Codable {
    public let id : Int?
    public let name: String?
    public let baseExperience: Int?
    public let height: Int?
    public let isDefault: Bool?
    public let order: Int?
    public let weight: Int?
    public let abilities: [PokemonAbilities]?
    public let forms: [PokemonModel]?
    public let gameIndices: [GameIndices]?
    public let heldItems: [HeldItems]?
    public let locationAreaEncounters: String?
    public let moves: [Moves]?
    public let sprites: Sprites?
    public let species: PokemonModel?
    public let stats: [Stats]?
    public let types: [Types]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case baseExperience = "base_experience"
        case height = "height"
        case isDefault = "is_default"
        case order = "order"
        case weight = "weight"
        case abilities = "abilities"
        case forms = "forms"
        case gameIndices = "game_indices"
        case heldItems = "held_items"
        case locationAreaEncounters = "location_area_encounters"
        case moves = "moves"
        case sprites = "sprites"
        case species = "species"
        case stats = "stats"
        case types = "types"
    }
}

