//
//  PokemonListResponse.swift
//  pokedex
//
//  Created by Prakash Koukuntla on 12/24/24.
//

import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable, Identifiable {
    let name: String
    var id: String { name }
    let url: String
    var details: PokemonDetail?
}

