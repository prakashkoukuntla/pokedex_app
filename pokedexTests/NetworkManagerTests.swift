//
//  NetworkManagerTests.swift
//  pokedex
//
//  Created by Prakash Koukuntla on 12/24/24.
//

import Foundation
import Testing
@testable import pokedex

struct NetworkManagerTests {

    @Test("Fetch Pokémon List")
    func testFetchPokemonList() async throws {
        // Arrange: Set offset and limit for pagination
        let offset = 0
        let limit = 2

        // Act: Fetch Pokémon list
        let response = try await NetworkManager.shared.fetchPokemonList(offset: offset, limit: limit)

        // Assert: Validate the response structure
        #expect(response.count > 0)
        #expect(response.results.count == limit)
        #expect(response.results[0].name == "bulbasaur")
        #expect(response.results[0].url == "https://pokeapi.co/api/v2/pokemon/1/")
    }

    @Test("Fetch Pokémon Detail")
    func testFetchPokemonDetail() async throws {
        // Arrange: Set a Pokémon ID to fetch details for
        let pokemonUrl = "https://pokeapi.co/api/v2/pokemon/1"

        // Act: Fetch Pokémon detail
        let detail = try await NetworkManager.shared.fetchPokemonDetail(urlString: pokemonUrl)

        // Assert: Validate the detail structure
        #expect(detail.sprites.front_default == "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        #expect(detail.sprites.back_shiny == "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png")
    }
}
