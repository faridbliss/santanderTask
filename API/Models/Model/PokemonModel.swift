//
//  PokemonModel.swift
//  API
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation

public struct PokemonModel: Codable {
   public let name: String
   public let url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}

