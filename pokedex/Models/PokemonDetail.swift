//
//  PokemonDetail.swift
//  pokedex
//
//  Created by Prakash Koukuntla on 12/24/24.
//

import Foundation

struct PokemonDetail: Codable {
    let sprites: Sprites
}

struct Sprites: Codable {
    let back_default: String?
    let back_female: String?
    let back_shiny: String?
    let back_shiny_female: String?
    let front_default: String?
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?

    let other: OtherSprites?
}

struct OtherSprites: Codable {
    let dream_world: DreamWorldSprites?
    let home: HomeSprites?
    let official_artwork: OfficialArtworkSprites?
    let showdown: ShowdownSprites?
    
    enum CodingKeys: String, CodingKey {
        case dream_world = "dream_world"
        case home = "home"
        case official_artwork = "official-artwork"
        case showdown = "showdown"
    }
}

struct DreamWorldSprites: Codable {
    let front_default: String?
    let front_female: String?
}

struct HomeSprites: Codable {
    let front_default: String?
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
}

struct OfficialArtworkSprites: Codable {
    let front_default: String?
    let front_shiny: String?
}

struct ShowdownSprites: Codable {
    let back_default: String?
    let back_female: String?
    let back_shiny: String?
    let back_shiny_female: String?
    let front_default: String?
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
}
