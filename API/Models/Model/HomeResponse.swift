//
//  HomeResponse.swift
//  API
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation

public struct HomeResponse: Codable {
   public let result: [PokemonModel]

   enum CodingKeys: String, CodingKey {
       case result = "results"
   }
}
