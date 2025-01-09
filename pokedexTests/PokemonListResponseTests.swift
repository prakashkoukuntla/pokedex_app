//
//  PokemonListResponseTests.swift
//  pokedex
//
//  Created by Prakash Koukuntla on 12/24/24.
//

import Foundation
import Testing
@testable import pokedex

struct PokemonListResponseTests {

    @Test("Decode PokemonListResponse from JSON")
    func testDecodePokemonListResponse() async throws {
        // Sample JSON data
        let jsonData = """
        {
            "count": 1302,
            "next": null,
            "previous": null,
            "results": [
                { "name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/" },
                { "name": "ivysaur", "url": "https://pokeapi.co/api/v2/pokemon/2/" }
            ]
        }
        """.data(using: .utf8)!

        // Decode the JSON data
        let decoder = JSONDecoder()
        let response = try decoder.decode(PokemonListResponse.self, from: jsonData)

        // Assert response properties
        #expect(response.count == 1302)
        #expect(response.next == nil)
        #expect(response.previous == nil)
        #expect(response.results.count == 2)

        // Assert details of individual Pokémon
        let firstPokemon = response.results[0]
        #expect(firstPokemon.name == "bulbasaur")
        #expect(firstPokemon.url == "https://pokeapi.co/api/v2/pokemon/1/")

        let secondPokemon = response.results[1]
        #expect(secondPokemon.name == "ivysaur")
        #expect(secondPokemon.url == "https://pokeapi.co/api/v2/pokemon/2/")
    }
}
