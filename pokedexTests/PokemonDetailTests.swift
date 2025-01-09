//
//  PokemonDetailTests.swift
//  pokedex
//
//  Created by Prakash Koukuntla on 12/24/24.
//

import Foundation
import Testing
@testable import pokedex

struct PokemonDetailTests {

    @Test("Decode PokemonDetail from JSON")
    func testDecodePokemonDetail() async throws {
        // Sample JSON data for sprites
        let jsonData = """
        {
            "sprites": {
                "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png",
                "back_female": null,
                "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png",
                "back_shiny_female": null,
                "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                "front_female": null,
                "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png",
                "front_shiny_female": null,
                "other": {
                    "dream_world": {
                        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/1.svg",
                        "front_female": null
                    },
                    "home": {
                        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png",
                        "front_female": null,
                        "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/1.png",
                        "front_shiny_female": null
                    },
                    "official-artwork": {
                        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
                        "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/1.png"
                    },
                    "showdown": {
                        "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/1.gif",
                        "back_female": null,
                        "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/shiny/1.gif",
                        "back_shiny_female": null,
                        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/1.gif",
                        "front_female": null,
                        "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/1.gif",
                        "front_shiny_female": null
                    }
                }
            }
        }
        """.data(using: .utf8)!

        // Decode the JSON data
        let decoder = JSONDecoder()
        let detail = try decoder.decode(PokemonDetail.self, from: jsonData)

        // Assert the main sprite properties
        #expect(detail.sprites.front_default == "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        #expect(detail.sprites.back_shiny == "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png")

        // Assert properties in the "other" section
        #expect(detail.sprites.other?.dream_world?.front_default == "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/1.svg")
        #expect(detail.sprites.other?.official_artwork?.front_default == "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")
    }
}
